module TransactionsHelper
  def options_for_credit_card_select(customer)
    {
      :collection => customer.credit_cards,
      :label_method => :masked_number,
      :include_blank => false,
    }
  end

  def new_transaction_path
    path ||= new_user_customer_credit_card_transaction_path(@user, @credit_card.id) if @credit_card
    path ||= new_user_customer_transaction_path(@user) if @user
    path ||= super
  end

  def back_path
    path ||= user_customer_credit_card_path(@user, @credit_card.id) if @credit_card
    path ||= user_customer_path(@user) if @user
    path ||= users_path
  end
end