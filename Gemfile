# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.11.5'
gem 'pg', '~> 1.4.5'
gem 'puma', '~> 4.1'
gem 'rack-cors', '~> 1.1.1'
gem 'rails', '~> 7.0.0'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 3.1.1'
  gem 'pry', platforms: %i[mri mingw x64_mingw]
  gem 'rails-controller-testing', '~> 1.0.5'
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'rubocop-rails', require: false
  gem 'spring', '~> 4.1.1'
  gem 'spring-watcher-listen', '~> 2.1.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
