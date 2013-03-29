# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#credit_card_billing_address_region').parent().parent().hide()
  states = $('#credit_card_billing_address_region').html()
  $('#credit_card_billing_address_country_code_alpha2').change ->
    country = $('#credit_card_billing_address_country_code_alpha2 :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(states).filter("optgroup[label=#{escaped_country}]").html()
    if options
      $('#credit_card_billing_address_region').html(options)
      $('#credit_card_billing_address_region').parent().parent().show()
    else
      $('#credit_card_billing_address_region').empty()
      $('#credit_card_billing_address_region').parent().parent().hide()
  $('#credit_card_billing_address_country_code_alpha2').change()
