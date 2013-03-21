require 'rails_ext/tag_helper_ext'
BraintreeRails::Configuration.environment = :sandbox
BraintreeRails::Configuration.logger = Logger.new('log/braintree.log')
BraintreeRails::Configuration.merchant_id = ENV['MERCHANT_ID']
BraintreeRails::Configuration.public_key = ENV['PUBLIC_KEY']
BraintreeRails::Configuration.private_key = ENV['PRIVATE_KEY']
