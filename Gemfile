source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '0.14.1'
gem 'devise', '2.2.3'

group:development, :test do
  gem "rspec-rails", "~> 2.12.2"
  gem "factory_girl_rails", "~> 4.2.0" 
  gem "guard-rspec", "~> 2.4.0"
  gem "pry", '0.9.12'
end

group:test do
  gem "faker", "~> 1.1.2"
  gem 'cucumber-rails', '1.3.1', :require => false
  gem "capybara", "~> 2.0.2"
  gem "database_cleaner", "~> 0.9.1" 
  gem "launchy", "~> 2.2.0"
  gem "email_spec", "1.4.0"
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem "therubyracer"
  gem "less-rails"
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'
