module BraintreeIntegration
  module Setup
    def braintree_integration_load_configuration
      load_configuration
      return if braintree_auth_set?
      pending("You need to provide real credentials in #{braintree_auth_file} to run #{self.class.description}")
    end

    def braintree_integration_setup_test_data
      @user = User.create(email: 'braintree-rails@example.com')
      create_customer_for(@user)
    end

    def braintree_integration_teardown
      Capybara.using_driver(:selenium) do
        login_into_control_panel
        purge_sandbox_data
      end
    end

    def purge_sandbox_data
      page.execute_script("$('#purge_sandbox_data_form').submit()")
      find('.ui-dialog-buttonset').find('span', text: 'Yes').click
    end

    def login_into_control_panel
      visit 'https://sandbox.braintreegateway.com/'
      fill_in_all(nil, configuration.slice('login', 'password'))
      click_button 'Sign In'
    end

    def self.included(receiver)
      receiver.before(:all) { braintree_integration_load_configuration }
      receiver.before(:each) { braintree_integration_setup_test_data }
      receiver.after(:all) { braintree_integration_teardown }
    end
  end
end
