# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.before(:all, type: :model) do
    BraintreeRails::Configuration.merchant_id = nil
    BraintreeRails::Configuration.public_key = nil
    BraintreeRails::Configuration.private_key = nil
    BraintreeRails::Configuration.client_side_encryption_key = nil
  end

  config.include(CapybaraHelper)
  config.include(BraintreeIntegration, braintree_integration: true)
end
