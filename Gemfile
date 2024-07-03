# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.3'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 6.4'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.2'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'turbo-rails'

gem 'slim-rails'

gem 'activerecord-session_store', '~> 2.1.0'

gem 'lexorank', '~> 0.1.3'

gem 'rack-attack'

gem 'jsbundling-rails'
gem 'cssbundling-rails'
gem 'propshaft'

gem 'inline_svg'

gem 'whenever', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'prosopite'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.9'
  gem 'brakeman'
  gem 'ruboconf-rails', '~> 1.15.0'
end

group :test do
  # Adds support for Capybara system testing and cuprite driver
  gem 'capybara', '>= 2.15'
  gem 'cuprite', github: 'rubycdp/cuprite', branch: 'main'

  gem 'shoulda'
  gem 'shoulda-context'
  gem 'rexml'
end

group :production do
  gem 'cloudflare-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
