require 'spec_helper'

describe "Customer Management", :braintree_integration => true do
  before :each do
    @user = User.create(:email => 'braintree-rails@example.com')
  end

  it "redirects to new customer path if not present" do
    visit user_customer_path(@user)
    current_path.should == new_user_customer_path(@user)
    find_field('Email').value.should == @user.email
  end

  it "creates customer by given attributes" do
    visit new_user_customer_path(@user)
    fill_in_all(customer_hash)
    click_button('Create Customer')
    current_path.should == user_customer_path(@user)
    page.should have_content('Customer has been successfully created.')

    @user.reload.customer.should_not be_nil
    customer_hash.each do |attribute, value|
      @user.customer.attributes[attribute].should == value
    end
  end

  it "shows customer attributes" do
    create_customer_for(@user, customer_hash)
    visit user_customer_path(@user)
    customer_hash.values.each do |value|
      page.should have_content(value)
    end
  end

  it "updates customer by given attributes" do
    create_customer_for(@user)
    visit edit_user_customer_path(@user)
    fill_in_all(:email => 'braintree-rails@example.org')
    click_button('Update Customer')
    page.should have_content('Customer has been successfully updated.')
    page.should have_content('braintree-rails@example.org')
  end

  it "destroys given customer" do
    customer = create_customer_for(@user)
    visit user_customer_path(@user)
    click_link("Destroy")
    current_path.should == user_path(@user)
    page.should have_content('Customer has been successfully deleted.')
    expect { BraintreeRails::Customer.find customer.id }.to raise_error(Braintree::NotFoundError)
  end
end
