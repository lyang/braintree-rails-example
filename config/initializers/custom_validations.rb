BraintreeRails::BillingAddressValidator::Validations = BraintreeRails::BillingAddressValidator::Validations.deep_dup
BraintreeRails::BillingAddressValidator::Validations << [:country_code_numeric, :inclusion => {:in => ['124', '840']}]
BraintreeRails::BillingAddressValidator.setup
