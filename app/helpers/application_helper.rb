module ApplicationHelper
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      type = :error   if type == :alert
      text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def options_for_credit_card_select(customer)
    {
      :collection => customer.credit_cards,
      :label_method => :masked_number,
      :include_blank => false,
    }
  end

  def options_for_plan_select
    {
      :collection => BraintreeRails::Plan.all,
      :label_method => :id,
      :include_blank => false,
    }
  end
end
