# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#transaction_billing_region').parent().parent().hide()
  states = $('#transaction_billing_region').html()
  $('#transaction_billing_country_code_alpha2').change ->
    country = $('#transaction_billing_country_code_alpha2 :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(states).filter("optgroup[label=#{escaped_country}]").html()
    if options
      $('#transaction_billing_region').html(options)
      $('#transaction_billing_region').parent().parent().show()
    else
      $('#transaction_billing_region').empty()
      $('#transaction_billing_region').parent().parent().hide()