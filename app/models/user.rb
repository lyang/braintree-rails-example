class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true
  after_destroy :destroy_customer

  def customer
    customer_id && BraintreeRails::Customer.new(customer_id)
  end

  private
  def destroy_customer
    BraintreeRails::Customer.delete(customer_id) if customer_id.present?
  end
end
