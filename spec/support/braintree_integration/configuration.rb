module BraintreeIntegration
  module Configuration
    def load_configuration
      @configuration = (YAML.load_file(braintree_auth_file) rescue {}).tap do |config|
        BraintreeRails::Configuration.merchant_id = config['merchant_id']
        BraintreeRails::Configuration.public_key = config['public_key']
        BraintreeRails::Configuration.private_key = config['private_key']
        BraintreeRails::Configuration.client_side_encryption_key = config['client_side_encryption_key']
      end
    end

    def configuration
      @configuration ||= load_configuration
    end

    def braintree_auth_file
      Rails.root.join("spec/support/braintree_integration/braintree_auth.yml")
    end

    def braintree_auth_set?
      BraintreeRails::Configuration.merchant_id.present? rescue false
    end
  end
end
