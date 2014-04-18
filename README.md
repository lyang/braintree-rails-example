# Welcome to braintree-rails-example
[braintree-rails-example](https://github.com/lyang/braintree-rails-example) is a demo rails app that uses [braintree-rails](https://github.com/lyang/braintree-rails) gem to intergrate with Braintree payment api.

This demo app shows how [braintree-rails](https://github.com/lyang/braintree-rails-example) simplified the code you needed in model/view/controller.

With the "railsy" models [braintree-rails](https://github.com/lyang/braintree-rails) provides, you can use them exactly "the rails way" as you would with any other ActiveRecord object.

In addition, the app uses Braintree.js for credit card data encryption. It helps you greatly reduce the PCI scope while keeps the flexibility.

## Instructions
Clone the repo

    git clone git://github.com/lyang/braintree-rails-example.git
    bundle install

Setup the database

    rake db:migrate

Then you need to edit `config/braintree.rb` to put in your Braintree sandbox credentials
```ruby
# Those are just delegation to Braintree::Configuration    
BraintreeRails::Configuration.environment = :sandbox
BraintreeRails::Configuration.logger = Logger.new('log/braintree.log')
BraintreeRails::Configuration.merchant_id = ENV['MERCHANT_ID']
BraintreeRails::Configuration.public_key = ENV['PUBLIC_KEY']
BraintreeRails::Configuration.private_key = ENV['PRIVATE_KEY']

# This is just a convenient place you can put your CSE key
BraintreeRails::Configuration.client_side_encryption_key = ENV['CLIENT_SIDE_ENCRYPTION_KEY']
```

Then you can start the demo with

    rails s

## Live demo
You can play with the live demo at [here](http://braintree-rails-example.herokuapp.com/).

**Caultion**
The live demo is for public *demo purpose only*.

**DO NOT** put any important or sensitive info in this demo.

It will be purged periodically.

## Sandbox environment for testing
You can get your sandbox env at https://www.braintreepayments.com/get-started
