module TransactionsHelper
  def options_for_credit_card_select(customer)
    {
      :collection => customer.credit_cards,
      :label_method => :masked_number,
      :include_blank => false,
    }
  end
end
