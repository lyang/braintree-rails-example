braintree-rails-example
===============
[braintree-rails-example](https://github.com/lyang/braintree-rails-example) provides a demo rails application that uses [braintree-rails](https://github.com/lyang/braintree-rails) gem to interact with Braintree api.

It demonstrates how [braintree-rails](https://github.com/lyang/braintree-rails-example) simplifies the interaction with reources stored in Braintree's vault.

You can do most of the CRUD operations on the wrapped models just as if they are ActiveRecord.

The demo app has only one user model, with two columns, email and customer_id.

All other models, Customer, CreditCard, Address are stored in Braintree's vault.

This branch uses Braintree's S2S (server to server) API, to demonstrate the capabilties of the [braintree-rails](https://github.com/lyang/braintree-rails-example) gem.

Transparent redirect examples
===============
With very minimum changes, TR (transparent redirect) API can also be used.

Check out the [transparent_redirect](https://github.com/lyang/braintree-rails-example/tree/transparent_redirect) branch for example.

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

    # Braintree::Configuration.merchant_id = ''
    # Braintree::Configuration.public_key = ''
    # Braintree::Configuration.private_key = ''

Then you can start the demo with
    rails s
    
Notice
===============
This IS NOT created or maintained by Braintree Payments

Where the abstraction leaks
===============
To load transactions of a customer or credit card, one have to use Braintree's search API.

What the search API returns is a lazy loading collection, which fires one API call for each item in the collection to load the full resource.

When you have a large number of transactions for a customer, it could be very slow. So, use it with caution.

Sandbox environment for testing
===============
You can get your sandbox env at https://www.braintreepayments.com/get-started