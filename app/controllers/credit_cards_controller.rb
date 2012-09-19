class CreditCardsController < ApplicationController
  before_filter :find_user, :find_customer
  before_filter :find_credit_card, :except => [:index, :new, :create, :tr_create]
  before_filter :parse_tr_data, :only => [:tr_update, :tr_create]
  
  def index
    @credit_cards = @customer.credit_cards    
  end

  def new
    billing_address = @customer.addresses.first || {}
    @credit_card = @customer.credit_cards.build({:cardholder_name => @customer.full_name, :billing_address => billing_address})
  end

  def create
    @credit_card = @customer.credit_cards.build(params[:credit_card])
    if @credit_card.save
      flash[:notice] = "Credit card has been successfully updated."
      redirect_to user_customer_credit_card_path(@user, @credit_card.id)
    else
      render :new
    end
  end

  def update
    if @credit_card.update_attributes(params[:credit_card])
      flash[:notice] = "Credit card has been successfully updated."
      redirect_to user_customer_credit_card_path(@user, @credit_card.id) and return
    else
      render :edit
    end    
  end

  def destroy
    @credit_card.destroy
    flash[:notice] = "Credit card has been successfully deleted."
    redirect_to user_customer_credit_cards_path(@user)
  end

  def tr_update
    if @credit_card.errors.empty?
      flash[:notice] = "Credit card has been successfully updated."
      redirect_to user_customer_credit_card_path(@user, @credit_card.id) and return
    else
      render :edit
    end
  end

  def tr_create
    if @credit_card.errors.empty?
      flash[:notice] = "Credit card has been successfully created."
      redirect_to user_customer_credit_card_path(@user, @credit_card.id) and return
    else
      render :new
    end
  end

  protected
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_customer
    @customer = BraintreeRails::Customer.find(@user.customer_id) if @user.customer_id.present?
    redirect_to user_path(@user) and return if @customer.nil?
  end

  def find_credit_card
    @credit_card = @customer.credit_cards.find(params[:id])
  end

  def parse_tr_data
    result = Braintree::TransparentRedirect.confirm(request.query_string)
    if result.success?
      @credit_card = BraintreeRails::CreditCard.new(result.credit_card)
    else
      @credit_card ||= BraintreeRails::CreditCard.new({})
      @credit_card.assign_attributes(result.params[:credit_card])
      @credit_card.add_errors(result.errors)
    end
  end
end