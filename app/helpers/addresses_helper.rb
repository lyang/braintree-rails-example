module AddressesHelper
  def options_for_country_select
    {
      collection: available_countries,
      value_method: :alpha_2_code,
      label: 'Country',
      include_blank: false,
    }
  end

  def options_for_region_select
    {
      collection: available_countries,
      as: :grouped_select,
      group_method: :subregions,
      value_method: :name,
    }
  end

  private
  def available_countries
    braintree_country_alpha_2_codes = Braintree::Address::CountryNames.map {|country| country[1]}
    Carmen::Country.all.select { |country| braintree_country_alpha_2_codes.include?(country.alpha_2_code) }.sort_by(&:name)
  end
end
