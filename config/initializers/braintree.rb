Braintree::Configuration.environment = :sandbox
Braintree::Configuration.logger = Logger.new('log/braintree.log')

Braintree::Configuration.merchant_id = ENV['MERCHANT_ID']
Braintree::Configuration.public_key = ENV['PUBLIC_KEY']
Braintree::Configuration.private_key = ENV['PRIVATE_KEY']

module ActionView
  module Helpers
    module TagHelper
      def tag_options_with_data_encrypted_name(options, escape = true)
        if options['data-encrypted-name']
          options['data-encrypted-name'] = options.delete("name")
        end
        tag_options_without_data_encrypted_name(options, escape)
      end
      alias_method_chain :tag_options, :data_encrypted_name
    end
  end
end
