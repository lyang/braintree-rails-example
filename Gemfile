source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '~> 4.0.3'
gem 'simple_form'
gem 'haml-rails'
gem 'carmen-rails'
gem 'thin'
gem 'jquery-rails'
gem 'braintree-rails', :github => "lyang/braintree-rails", :branch => 'master'
gem 'coffee-rails', '~> 4.0.1'
gem 'uglifier', '>= 2.5.0'
gem 'therubyracer', :platforms => :ruby
gem "less-rails"
gem 'twitter-bootstrap-rails'

group :development, :test do
  gem 'quiet_assets'
  gem 'sqlite3'
  gem 'rspec-rails', "~> 2.14.2"
end

group :test do
  gem 'capybara'
  gem "launchy"
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :production do
  gem 'newrelic_rpm'
  gem 'pg'
  gem 'rails_on_heroku'
end
