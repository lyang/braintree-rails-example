module CreditCardsHelper
  def braintree_tr_data
    if @credit_card.persisted?
      Braintree::TransparentRedirect.update_credit_card_data(
        :redirect_url => tr_update_user_customer_credit_card_url(@user, @credit_card.id),
        :payment_method_token => @credit_card.token
      )
    else
      Braintree::TransparentRedirect.create_credit_card_data(
        :redirect_url => tr_create_user_customer_credit_cards_url(@user),
        :credit_card => {:customer_id => @customer.id}
      )
    end
  end

  def options_for_country_select
    {
      :collection => available_countries,
      :value_method => :alpha_2_code,
      :label => 'Country',
      :include_blank => false,
    }
  end

  def options_for_region_select
    {
      :collection => available_countries,
      :as => :grouped_select,
      :group_method => :subregions,
      :value_method => :name,
    }
  end

  def options_for_month_select
    {
      :collection => Date::MONTHNAMES.each_with_index.to_a[1..-1].map { |month, index| [month, index.to_s.rjust(2, '0')]},
      :include_blank => false,
    }
  end

  def options_for_year_select
    {
       :collection => 1976..2200,
       :include_blank => false,
    }
  end

  private
  def available_countries
    braintree_country_alpha_2_codes = Braintree::Address::CountryNames.map {|country| country[1]}
    Carmen::Country.all.select { |country| braintree_country_alpha_2_codes.include?(country.alpha_2_code) }.sort_by(&:name)
  end
end