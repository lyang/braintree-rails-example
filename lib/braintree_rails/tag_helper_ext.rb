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
