ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)

# To prevent tests running twice (doesn't work)
#if ENV.keys.grep(/ZEUS/).any?
#  require 'minitest/unit'
#  MiniTest::Unit.class_variable_set("@@installed_at_exit", true)
#end

require 'rails/test_help'
require 'pry'
require 'byebug'
require 'capybara/rails'
require 'capybara/poltergeist'
#require "minitest/reporters"
#MiniTest::Reporters.use!


Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, debug: false, js_errors: false, inspector: true)
end
Capybara.javascript_driver = :selenium


Turn.config.trace = 1
#Turn.config.format = :dot


# Includes support files
Dir[Rails.root.join("test/support/**/*.rb")].each {|f| require f}


class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Add more helper methods to be used by all tests here...
end


# Only for integration tests
class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def self.js_driver
     before { Capybara.current_driver = Capybara.javascript_driver }
     after  { Capybara.current_driver = Capybara.default_driver }
  end

  def use_js_driver
     Capybara.current_driver = Capybara.javascript_driver
  end

  def use_default_driver
     Capybara.current_driver = Capybara.default_driver
  end

  #before do
  #  if metadata[:js] == true
  #    Capybara.current_driver = Capybara.javascript_driver
  #  else
  #    Capybara.current_driver = Capybara.default_driver
  #  end
  #end

  # Recommended if not using shared db connection.
  #after do
  #   DatabaseCleaner.clean
  #   Capybara.reset_sessions!
  #end
end

# Must be loaded at end.
require 'mocha/setup'
