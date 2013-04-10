module BraintreeIntegration
  module Setup
    def braintree_integration_setup
      load_configuration
      return if braintree_auth_set?
      pending("You need to provide real credentials in #{braintree_auth_file} to run #{self.class.description}")
    end

    def braintree_integration_teardown
      Capybara.using_driver(:selenium) do
        login_into_control_panel
        purge_sandbox_data
      end
    end

    def purge_sandbox_data
      find('#account_menu').click
      click_link 'Purge Sandbox Data'
      find('.ui-dialog-buttonset').find('span', :text => 'Yes').click
    end

    def login_into_control_panel
      visit 'https://sandbox.braintreegateway.com/'
      fill_in 'login', :with => configuration['username']
      fill_in 'password', :with => configuration['password']
      click_button 'Sign In'
    end

    def self.included(receiver)
      RSpec.configure do |config|
        config.before(:all, :braintree_integration => true) { braintree_integration_setup }
        config.after(:all, :braintree_integration => true) { braintree_integration_teardown }
      end
    end
  end
end
