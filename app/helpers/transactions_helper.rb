module TransactionsHelper
  def new_transaction_path
    path ||= new_user_customer_credit_card_transaction_path(@user, @credit_card) if @credit_card
    path ||= new_user_customer_transaction_path(@user) if @user
    path ||= super
  end

  def edit_subscription_path(subscription)
    path ||= edit_user_customer_credit_card_subscription_path(@user, @credit_card, subscription) if @credit_card
    path ||= edit_plan_subscription_path(@plan, subscription) if @plan
    path ||= super(subscription)
  end

  def back_path
    path ||= user_customer_credit_card_path(@user, @credit_card) if @credit_card
    path ||= user_customer_path(@user) if @user
    path ||= users_path
  end
end
