require 'spec_helper'

describe "Address Management", braintree_integration: true do
  it "shows a list of plans" do
    address = @user.customer.addresses.create!(address_hash)
    visit user_customer_addresses_path(@user)
    page.should have_link(address.street_address, href: user_customer_address_path(@user, address))
  end

  it "shows plan attributes" do
    address = @user.customer.addresses.create!(address_hash)
    visit user_customer_address_path(@user, address)
    address_hash.values.each do |value|
      page.should have_content(value)
    end
  end
end
