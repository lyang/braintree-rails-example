braintree-rails-example
===============
braintree-rails-example provides a sample rails application that uses braintree-rails gem to interact with Braintree payments api.

It demonstrates how braintree-rails simplifies the management of reources stored in Braintree's vault.

Currently it uses Braintree's S2S API.

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

Then you can start the sample with
    rails s
    
notice
===============
This IS NOT created or maintained by Braintree Payments

You can get your sandbox env at https://www.braintreepayments.com/get-started