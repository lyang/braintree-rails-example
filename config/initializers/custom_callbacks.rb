[User, BraintreeRails::Address, BraintreeRails::Customer, BraintreeRails::CreditCard, BraintreeRails::Transaction, BraintreeRails::Subscription].each do |model|
  model.after_create do
    HistoryEvent.create_from(self)
  end
end