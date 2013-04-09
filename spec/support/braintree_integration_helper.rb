module BraintreeIntegrationHelper
  extend self

  def extended(receiver)
    config!
  end

  def configuration
    @configuration ||= YAML.load_file(braintree_auth_file) rescue {}
  end

  def config!
    BraintreeRails::Configuration.environment = :sandbox
    BraintreeRails::Configuration.merchant_id = configuration['merchant_id']
    BraintreeRails::Configuration.public_key = configuration['public_key']
    BraintreeRails::Configuration.private_key = configuration['private_key']
    BraintreeRails::Configuration.client_side_encryption_key = configuration['client_side_encryption_key']
  end

  def braintree_auth_set?
    BraintreeRails::Configuration.merchant_id.present? rescue false
  end

  def braintree_auth_file
    Rails.root.join("spec/support/braintree_auth.yml")
  end

  def validate_braintree_auth
    return if braintree_auth_set?
    pending("You need to provide real credentials in #{braintree_auth_file} to run #{self.class.description}")
  end

  def purge_data
    with_external_access do
      login_into_control_panel
      purge_sandbox_data
    end
  end

  def purge_sandbox_data
    find('#account_menu').click
    click_link 'Purge Sandbox Data'
    find('.ui-dialog-buttonset').find('span', :text => 'Yes').click
  end

  def with_external_access(&block)
    Capybara.using_driver(:selenium, &block)
  end

  def login_into_control_panel
    visit 'https://sandbox.braintreegateway.com/'
    fill_in 'login', :with => configuration['username']
    fill_in 'password', :with => configuration['password']
    click_button 'Sign In'
  end
end
