Changes made to use TR (transparent redirect)
===============
1. Force the form url to use Braintree::TransparentRedirect.url

2. Force the form method to :post, as by default rails uses :put (hidden field) for updating resources, which will be rejected by Braintree's gateway in the TR scenario.

3. Added two actions accessbile through GET, as the TR's redirect_url

4. Some other very minor changes

braintree-rails-example
===============
[braintree-rails-example](https://github.com/lyang/braintree-rails-example) provides a demo rails application that uses [braintree-rails](https://github.com/lyang/braintree-rails) gem to interact with Braintree api.

It demonstrates how [braintree-rails](https://github.com/lyang/braintree-rails-example) simplifies the interaction with reources stored in Braintree's vault.

You can do most of the CRUD operations on the wrapped models just as if they are ActiveRecord.

The demo app has only one user model, with two columns, email and customer_id.

All other models, Customer, CreditCard, Address are stored in Braintree's vault.

Currently it uses Braintree's S2S (server to server) API.

Examples of TR (transparent redirect) will be added later.

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

You can get your sandbox env at https://www.braintreepayments.com/get-started