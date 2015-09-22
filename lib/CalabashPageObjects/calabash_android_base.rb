require 'calabash-android/abase'
require 'calabash-android/operations'
require 'calabash-android'
require_relative 'shared_methods'
# Creating methods from the defined elements
class CalabashAndroidBase < Calabash::ABase
  # rubocop:disable CyclomaticComplexity
  # rubocop:disable PerceivedComplexity
  # rubocop:disable AbcSize
  # rubocop:disable NestedMethodDefinition

  CPO_LOGGING ||= false

  def self.element(element_name, locator)
    define_method(element_name.to_s) do
      query("#{locator}")
    end

    define_method("#{element_name}_when_present") do |options = {}|
      opts = options_parser(options, timeout: 20)
      puts "Waiting for #{element_name} to appear..." if CPO_LOGGING
      wait_for_element_exists(locator, timeout: opts[:timeout], screenshot_on_error: false)
    end

    define_method("#{element_name}_when_not_present") do |options = {}|
      opts = options_parser(options, timeout: 20)
      puts "Waiting for #{element_name} to not be present..." if CPO_LOGGING
      wait_for_element_does_not_exist(locator, timeout: opts[:timeout], screenshot_on_error: false)
    end

    define_method("#{element_name}_present?") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      unless find(element_name, opts[:timeout], opts[:parent], opts[:webview])
        fail Calabash::Android::WaitHelpers::WaitError, "Timeout waiting for elements: #{locator}"
      end
    end

    define_method("touch_#{element_name}") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)
      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      puts "Touching #{element_name}..." if CPO_LOGGING
      touch(locator)
    end

    define_method("input_#{element_name}") do |value, options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      puts "Clearing text from #{element_name}..." if CPO_LOGGING
      clear_text_in(locator)
      puts "Entering text in #{element_name}..." if CPO_LOGGING
      enter_text(locator, value)
    end

    define_method("check_#{element_name}") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      puts "Setting checkbox #{element_name} to checked..." if CPO_LOGGING
      query("#{locator}", setChecked: true)
    end

    define_method("uncheck_#{element_name}") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      puts "Setting checkbox #{element_name} to unchecked..." if CPO_LOGGING
      query("#{locator}", setChecked: false)
    end

    define_method("#{element_name}_checked?") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      puts "Checking status of #{element_name} checkbox..." if CPO_LOGGING
      query("#{locator}", :isChecked)
    end

    define_method("#{element_name}_text") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      puts "Retrieving text from #{element_name}..." if CPO_LOGGING
      query("#{locator}", :text)[0]
    end

    define_method("#{element_name}_look_for") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      unless find(element_name, opts[:timeout], opts[:parent], opts[:webview])
        fail Calabash::Android::WaitHelpers::WaitError, "Timeout waiting for elements: #{locator}"
      end
    end

    define_method("#{element_name}_present?") do |options = {}|
      opts = options_parser(options, timeout: 1)
      puts "Checking for the presence of #{element_name} after #{opts[:timeout]} seconds..." if CPO_LOGGING

      begin
        wait_for_element_exists(locator, timeout: opts[:timeout], screenshot_on_error: false)
        true
      rescue
        false
      end
    end

    define_method("#{element_name}_locator") do
      return locator
    end
  end
end
