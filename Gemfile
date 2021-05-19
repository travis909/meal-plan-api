# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

gem 'active_model_serializers', '~> 0.10.10'
gem 'bcrypt'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'fast_jsonapi'
gem 'hirb'
gem 'jwt', '~> 2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 3.9'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]