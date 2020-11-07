# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.register_driver(:chrome) do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  # Run headless by default unless CHROME_HEADLESS specified
  options.add_argument('headless') unless /^(false|no|0)$/i.match?(ENV['CHROME_HEADLESS'])

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.configure do |config|
  config.server = :webrick
  config.default_driver = :chrome
  config.javascript_driver = :chrome
end
