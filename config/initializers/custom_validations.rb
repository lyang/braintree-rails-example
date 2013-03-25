BraintreeRails::BillingAddressValidator.setup do |validations|
  validations << [:country_name, :inclusion => { :in => ["Canada", "United States of America"], :message => "%{value} is not supported yet." }]
end
