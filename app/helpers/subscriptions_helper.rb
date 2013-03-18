module SubscriptionsHelper

  def new_subscription_path
    path ||= new_user_customer_credit_card_subscription_path(@user, @credit_card) if @credit_card
    path ||= new_plan_subscription_path(@plan) if @plan
    path ||= super
  end

  def back_path
    path ||= user_customer_credit_card_path(@user, @credit_card) if @credit_card
    path ||= plan_path(@plan) if @plan
    path ||= users_path
  end
end
