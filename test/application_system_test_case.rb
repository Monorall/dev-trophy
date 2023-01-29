require "test_helper"
#require 'webdrivers'
#require 'selenium-webdriver'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  #Capybara.current_driver = :selenium_chrome_headless
  #Capybara.app_host = 'https://forms.ingipro.ml/'
  #ActiveRecord::Base.connection.execute("BEGIN TRANSACTION; END;")

  driven_by :selenium, using: :headless_firefox
  #driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  
  #Capybara.register_driver :headless_chrome do |app|
  #  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
  #    chromeOptions: { args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage] --remote-debugging-port=9222}
  #  )
  
  #  Capybara::Selenium::Driver.new app,
  #                                 browser: :chrome,
  #                                 desired_capabilities: capabilities
  #end
  #driver = Selenium::WebDriver.for :chrome
  #Capybara.run_server = false
  
  #Capybara.register_driver(:headless_chrome) do |app|
  #  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
  #    chromeOptions: { args: %w[headless disable-gpu no-sandbox] } 
  #  )
  #  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
  #end
  #Capybara.register_driver :chrome_headless do |app|
  #  options = Selenium::WebDriver::Chrome::Options.new(
  #    args: %w[headless disable-gpu no-sandbox]
  #  )
  #  Capybara::Selenium::Driver.new(app, browser: :headless_chrome, options: options)
  #end
  
  #Capybara.javascript_driver = :chrome
  #options = Selenium::WebDriver::Chrome::Options.new
  #options.add_argument "--headless"
  #driver = Selenium::WebDriver.for(:chrome, options: options)
  #driver.get('https://forms.ingipro.ml/')
  #driver.quit

  #options = Selenium::WebDriver::Chrome::Options.new
  #options.add_preference(:download, prompt_for_download: false, default_directory: '/tmp/downloads')
  #options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })

  #Capybara.register_driver :chrome do |app|
  #  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  #end

  #Capybara.register_driver :headless_chrome do |app|
  #  options.add_argument('--headless')
  #  options.add_argument('--disable-gpu')
  #  options.add_argument('--window-size=1280,800')
  #  options.add_argument('--no-sandbox')

  #  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  #end

  #Capybara.javascript_driver = :headless_chrome
end
