class CustomersController < ApplicationController
  before_filter :find_user
  before_filter :find_customer, :except => [:new, :create]

  def new
    @customer = BraintreeRails::Customer.new(:email => @user.email)
  end

  def create
    @customer = BraintreeRails::Customer.build(params[:customer])
    if @customer.save
      @user.update_attribute(:customer_id, @customer.id)
      flash[:notice] = "Customer has been successfully created."
      redirect_to user_customer_path(@user) and return
    else
      render :new
    end
  end

  def show
    if @customer.nil?
      redirect_to new_user_customer_path(@user) and return
    end
  end

  def edit; end

  def update
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Customer has been successfully updated."
      redirect_to user_customer_path(@user) and return
    else
      render :new
    end
  end

  def destroy
    @customer.destroy
    @user.update_attribute(:customer_id, nil)
    flash[:notice] = "Customer has been successfully deleted."
    redirect_to user_path(@user)
  end

  protected
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_customer
    @customer = BraintreeRails::Customer.find(@user.customer_id) if @user.customer_id.present?
  end
end