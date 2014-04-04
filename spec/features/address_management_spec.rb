require 'spec_helper'

describe "Address Management", braintree_integration: true do

  it "shows a list of addresses of given customer" do
    address = @user.customer.addresses.create!(address_hash)
    visit user_customer_addresses_path(@user)
    page.should have_link(address.street_address, href: user_customer_address_path(@user, address))
  end

  it "creates address by given attributes" do
    visit new_user_customer_address_path(@user)
    fill_in_all(:address, address_hash)
    click_button('Create Address')
    page.should have_content('Address has been successfully created.')

    address = @user.customer.addresses.find(current_path.split('/').last)

    address_hash.each do |attribute, value|
      address.attributes[attribute].should == value
    end
  end

  it "shows address attributes" do
    address = @user.customer.addresses.create!(address_hash)
    visit user_customer_address_path(@user, address)
    address_hash.values.each do |value|
      page.should have_content(value)
    end
  end

  it "updates address by given attributes" do
    address = @user.customer.addresses.create!(address_hash)
    visit edit_user_customer_address_path(@user, address)
    fill_in_all(:address, postal_code: '12345')
    click_button('Update Address')
    page.should have_content('Address has been successfully updated.')
    page.should have_content('12345')
  end

  it "destroys given address" do
    address = @user.customer.addresses.create!(address_hash)
    visit user_customer_address_path(@user, address)
    click_link("Destroy")
    current_path.should == user_customer_addresses_path(@user)
    page.should have_content('Address has been successfully deleted.')
    expect { BraintreeRails::Address.find @user.customer.id, address.id }.to raise_error(Braintree::NotFoundError)
  end
end
