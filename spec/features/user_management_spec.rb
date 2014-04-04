require 'spec_helper'

describe "User Management" do
  before(:each) do
    @user = User.create!(email: 'braintree-rails@example.com')
  end

  it "creates user by given email" do
    visit users_path
    click_link 'New'
    fill_in 'Email', with: 'braintree-rails@example.org'
    click_button 'Create User'
    current_path.should == user_path(User.last)
    page.should have_content('User was successfully created.')
    page.should have_content('braintree-rails@example.org')
  end

  it "shows given user" do
    visit user_path(@user)
    page.should have_content('braintree-rails@example.com')
    page.should have_link('Back')
    page.should have_link('Edit', href: edit_user_path(@user))
    page.should have_link('Customer', href: user_customer_path(@user))
    page.should have_link('Destroy')
  end

  it "shows list of users" do
    visit users_path
    page.should have_link(@user.email, href: user_path(@user))
  end

  it "update given user" do
    visit edit_user_path(@user)
    fill_in 'Email', with: 'braintree-rails@example.org'
    click_button 'Update User'
    current_path.should == user_path(@user)
    page.should have_content('User was successfully updated.')
    page.should have_content('braintree-rails@example.org')
  end

  it "destroys given user" do
    visit user_path(@user)
    click_link 'Destroy'
    page.should have_content('User was successfully destroyed.')
    User.exists?(@user.id).should be_false
  end
end
