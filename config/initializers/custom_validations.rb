BraintreeRails::BillingAddressValidator.setup do |validations|
  validations << [:country_code_alpha2, inclusion: { in: ["CA", "US"] }]
end
