source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '~> 3.2.13'
gem 'simple_form'
gem 'haml-rails'
gem 'carmen-rails'

gem 'braintree-rails', :github => "lyang/braintree-rails", :branch => 'master'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platforms => :ruby
  gem 'twitter-bootstrap-rails'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', "~> 2.0"
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
end

gem 'jquery-rails'
