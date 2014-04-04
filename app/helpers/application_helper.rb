module ApplicationHelper
  def bootstrap_flash
  end

  def options_for_credit_card_select(customer)
    {
      collection: customer.credit_cards,
      label_method: :masked_number,
      include_blank: false,
    }
  end

  def options_for_plan_select
    {
      collection: BraintreeRails::Plan.all,
      label_method: :id,
      include_blank: false,
    }
  end
end
