ENV['RACK_ENV'] = 'test'

require_relative '../server'
require 'capybara/rspec'
require 'database_cleaner'
require 'coveralls'
require 'simplecov'

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
Coveralls.wear!
