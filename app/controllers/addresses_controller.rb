class AddressesController < ApplicationController
  before_filter :find_user, :find_customer
  before_filter :find_address, except: [:new, :create]

  def index
    @addresses = @customer.addresses
  end

  def new
    @address = @customer.addresses.build(country_code_alpha2: 'US', region: 'California')
  end

  def edit; end

  def show; end

  def create
    @address = @customer.addresses.build(params[:address])
    if @address.save
      flash[:notice] = "Address has been successfully created."
      redirect_to user_customer_address_path(@user, @address)
    else
      flash[:alert] = @address.errors.full_messages.join(".\n")
      render :new
    end
  end

  def update
    if @address.update_attributes(params[:address])
      flash[:notice] = "Address has been successfully updated."
      redirect_to user_customer_address_path(@user, @address) and return
    else
      flash[:alert] = @address.errors.full_messages.join(".\n")
      render :edit
    end
  end

  def destroy
    @address.destroy
    flash[:notice] = "Address has been successfully deleted."
    redirect_to user_customer_addresses_path(@user)
  end

  protected
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_customer
    @customer = @user.customer
    redirect_to user_path(@user) and return if @customer.nil?
  end

  def find_address
    @address = @customer.addresses.find(params[:id])
  end
end
