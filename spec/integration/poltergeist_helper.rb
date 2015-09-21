# Setup dependencies
ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require "capybara/rails"
require 'capybara/poltergeist'

TEST_BASE = File.dirname(__FILE__).freeze
Dir[TEST_BASE + '/page_objects/*/*'].each(&method(:require))

# Configure Rspec
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end

# Configure Capybara driver
Capybara.register_driver :poltergeist do |app|
  options = {
    window_size: [1200,900],
    js_errors: true
  }
  Capybara.app_host = 'http://localhost:9554'
  Capybara.server_port = 9554
  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
  Capybara::Poltergeist::Driver.new(app, options)
end

module HorizonIntegration
  class PoltergeistIntegrationTest < ActionDispatch::IntegrationTest
    include Capybara::DSL
    
    # take_screenshot : A way for the developer to take screenshots during tests
    #=> nil
    def take_screenshot
      path = Rails.root.join('test/integration/screenshots/')
      i = Dir[path.join("*.png")].length + 1
      name = "screenshot#{i}.png"
      page.save_screenshot(path + name)
      puts "Screenshot saved: #{path.to_s + name}"
    end
  end
end
