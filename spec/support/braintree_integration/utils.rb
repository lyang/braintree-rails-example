module BraintreeIntegration
  module Utils
    def create_customer_for(user, attributes = customer_hash)
      BraintreeRails::Customer.create!(attributes).tap do |customer|
        user.update_attribute(:customer_id, customer.id)
      end
    end
  end
end
