braintree-rails-example
===============
[braintree-rails-example](https://github.com/lyang/braintree-rails-example) provides a demo rails application that uses [braintree-rails](https://github.com/lyang/braintree-rails) gem to interact with Braintree api.

It demonstrates how [braintree-rails](https://github.com/lyang/braintree-rails-example) simplifies the interaction with resources stored in Braintree's vault.

You can do most of the CRUD operations on the wrapped models just as if they are ActiveRecord.

The demo app has only one user model, with two columns, email and customer_id.

All other models, Customer, CreditCard, Address are stored in Braintree's vault.

Master branch uses Braintree's S2S (server to server) API, to demonstrate the capabilties of the [braintree-rails](https://github.com/lyang/braintree-rails-example) gem.

Transparent redirect examples
===============
With very minimum changes, TR (transparent redirect) API can also be used.

Check out the [transparent_redirect](https://github.com/lyang/braintree-rails-example/tree/transparent_redirect#changes-made-to-use-tr-transparent-redirect) branch for example.

Live demo
===============
You can play with the live demo at [here](http://braintree-rails-example.herokuapp.com/).

**Caultion**
The live demo is for public demo purpose only.

**DO NOT** put any important or sensitive info in this demo.

It will be purged periodically.

Instructions
===============
Clone the repo

    git clone git://github.com/lyang/braintree-rails-example.git
    bundle install

Setup the database

    rake db:migrate

Then you need to edit config/braintree.rb to put in your Braintree sandbox credentials

    Braintree::Configuration.environment = :sandbox
    Braintree::Configuration.logger = Logger.new('log/braintree.log')

    Braintree::Configuration.merchant_id = ENV['MERCHANT_ID']
    Braintree::Configuration.public_key = ENV['PUBLIC_KEY']
    Braintree::Configuration.private_key = ENV['PRIVATE_KEY']

Then you can start the demo with

    rails s

Todo
===============
Deprecating both S2S and TR branch in favor of Braintree.js implementations.

Sandbox environment for testing
===============
You can get your sandbox env at https://www.braintreepayments.com/get-started
