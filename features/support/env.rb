#encoding: utf-8
#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/../../features/support/utils')

require 'pry-byebug'
require 'rspec'
require 'faker'
require 'capybara/cucumber'
require 'capybara/rspec'
require 'capybara-screenshot/cucumber'
require 'capybara-screenshot/rspec'
require 'capybara-screenshot'
require 'selenium-webdriver'
require 'site_prism'
require 'yaml'

$DATA_ENDERECOS = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../../config/enderecos.yml'))
$DATA_URLS = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../../config/urls.yml'))

# Define o navegador a ser utilizado
driver = nil
case ENV['BROWSER']
  when 'chrome'
	Capybara.register_driver :chrome do |app|
	  caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => [ "disable-extensions", "start-maximized" ]})
	  Capybara::Selenium::Driver.new(app, :browser => :chrome, :desired_capabilities => caps)
	end
	driver = :chrome
  when 'firefox'
	driver = :selenium
  else
end

# Start driver
Capybara.configure do |config|
  config.run_server = false
  config.default_driver = driver
end

Capybara.default_max_wait_time = 10
Capybara.ignore_hidden_elements = false
Capybara::Screenshot.autosave_on_failure = false
Capybara::Screenshot::RSpec::REPORTERS["RSpec::Core::Formatters::HtmlFormatter"] = Capybara::Screenshot::RSpec::HtmlEmbedReporter

# Executa ação pré-determinada após a execução
After do |scenario|
  screenshot = Utils.timestamp + '.png'
  page.save_screenshot(screenshot, full: true)
  embed(screenshot, 'image/png')

  window = page.driver.browser.window_handles
  if window.size > 1
	page.driver.browser.switch_to.window(window.last)
	page.driver.browser.close
	page.driver.browser.switch_to.window(window.first)
  end
end
