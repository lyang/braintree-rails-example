require 'spec_helper'

describe User do
  describe '#email' do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
  end

  describe "#customer" do
    it "returns nil if customer_id is not set" do
      User.new.customer.should be_nil
    end

    it "returns BraintreeRails::Customer if customer_id presents" do
      customer = BraintreeRails::Customer.new
      BraintreeRails::Customer.should_receive(:new).with('foo').and_return(customer)
      User.new(customer_id: 'foo').customer.should == customer
    end

    it "should delete customer if customer_id presents" do
      BraintreeRails::Customer.should_receive(:delete).with('foo')
      User.create(email: 'braintree-rails@example.com', customer_id: 'foo').destroy
    end
  end
end
