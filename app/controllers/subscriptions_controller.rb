class SubscriptionsController < ApplicationController
  before_filter :find_subscriptions
  before_filter :find_subscription, :except => [:index, :create]
  helper_method :subscription_path, :subscriptions_path

  def index; end

  def show; end

  def edit; end

  def new
    @subscription = @subscriptions.build
  end

  def create
    @subscription = @subscriptions.build(params[:subscription])
    if @subscription.save
      flash[:notice] = "Subscription has been successfully created."
      redirect_to subscription_path(@subscription)
    else
      flash[:alert] = @subscription.errors.full_messages.join("\n")
      render :new
    end
  end

  def update
    if @subscription.update_attributes(params[:subscription])
      flash[:notice] = "Customer has been successfully updated."
      redirect_to subscription_path(@subscription) and return
    else
      flash[:alert] = @subscription.errors.full_messages.join("\n")
      render :edit
    end
  end

  def destroy
    @subscription.destroy
    flash[:notice] = "Subscription has been successfully canceled."
    redirect_to subscriptions_path
  end

  protected

  def find_subscriptions
    if find_credit_card
      @subscriptions = @credit_card.subscriptions
    elsif find_plan
      @subscriptions = @plan.subscriptions
    else
      @subscriptions = BraintreeRails::Subscriptions.new(nil)
    end
  end

  def find_subscription
    @subscription = @subscriptions.find(params[:id])
  end

  def find_credit_card
    @user = User.find(params[:user_id]) if params[:user_id].present?
    @customer = BraintreeRails::Customer.find(@user.customer_id) if @user && @user.customer_id.present?
    @credit_card = @customer.credit_cards.find(params[:credit_card_id]) if @customer && params[:credit_card_id].present?
  end

  def find_plan
    @plan = BraintreeRails::Plan.find(params[:plan_id]) if params[:plan_id].present?
  end

  def subscriptions_path
    path ||= user_customer_credit_card_subscriptions_path(@user, @credit_card.id) if @credit_card
    path ||= plan_subscriptions_path(@plan) if @plan
    path ||= super
  end


  def subscription_path(subscription, options={})
    path ||= user_customer_credit_card_subscription_path(@user, @credit_card.id, subscription.id, options) if @credit_card
    path ||= plan_subscription_path(@plan, subscription.id, options) if @plan
    path ||= super(subscription.id, options)
  end
end
