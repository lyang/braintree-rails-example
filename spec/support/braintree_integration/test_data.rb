module BraintreeIntegration
  module TestData
    def customer_hash
      {
        first_name: "Brain",
        last_name: "Tree",
        email: 'braintree-rails@example.com'
      }
    end

    def address_hash
      {
        first_name: 'Brain',
        last_name: 'Tree',
        company: 'Braintree',
        street_address: "1134 Crane Avenue",
        extended_address: "Suite 200",
        locality: 'Menlo Park',
        region: 'California',
        postal_code: '94025',
        country_code_alpha2: 'US'
      }
    end

    def credit_card_hash
      {
        number: (Braintree::Test::CreditCardNumbers::All - Braintree::Test::CreditCardNumbers::AmExes).shuffle.first,
        cvv: ("000".."999").to_a.shuffle.first,
        cardholder_name: 'Brain Tree',
        expiration_month: ("01".."12").to_a.shuffle.first,
        expiration_year: ("2012".."2035").to_a.shuffle.first,
        billing_address: address_hash,
      }
    end
  end
end
