source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '4.1.6'
gem 'jquery-ui-rails'
gem 'jquery-turbolinks'
gem 'capistrano', '~> 2'
gem 'twitter-bootstrap-rails'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'devise', '~> 3.1'
gem 'draper', '~> 1.3'
gem 'state_machine'
gem 'pry'
gem 'whenever', :require => false

group :development do
  gem 'letter_opener'
  gem 'quiet_assets'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-email'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'capybara-webkit'
  gem 'selenium-webdriver', '~> 2.35'
  gem 'timecop'
  gem 'jasminerice', git: 'git://github.com/bradphelan/jasminerice.git'
  gem 'fakeredis', require: 'fakeredis/rspec'
  gem 'parallel_tests'
end

group :test do
  gem 'sqlite3'
  gem 'webmock'
  gem 'vcr'
  gem 'sinatra', require: false
  gem 'rspec-set'
end