require_relative 'braintree_integration/configuration'
require_relative 'braintree_integration/setup'
require_relative 'braintree_integration/test_data'
require_relative 'braintree_integration/utils'

BraintreeRails::Configuration.environment = :sandbox
BraintreeRails::Configuration.logger = Logger.new('/dev/null').tap { |logger| logger.level = Logger::INFO }

module BraintreeIntegration
  def self.included(receiver)
    receiver.send :include, Configuration
    receiver.send :include, Setup
    receiver.send :include, TestData
    receiver.send :include, Utils
  end
end
