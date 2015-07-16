require 'calabash-android/abase'
require 'calabash-android/operations'
# Creating methods from the defined elements
class CalabashAndroidBase < Calabash::ABase
  # rubocop:disable CyclomaticComplexity
  # rubocop:disable PerceivedComplexity
  # rubocop:disable AbcSize
  # rubocop:disable NestedMethodDefinition
  def self.element(element_name, locator)
    define_method(element_name.to_s) do
      query("#{locator}")
    end

    def options_parser(input_options, defaults = {})
      if input_options.is_a?(Integer)
        timeout_only_output_options = {}
        timeout_only_output_options[:timeout] = input_options
        timeout_only_output_options
      else
        defaults.merge(input_options)
      end
    end

    define_method("#{element_name}_when_present") do |options = {}|
      opts = options_parser(options, timeout: 20)
      wait_for_element_exists(locator, timeout: opts[:timeout], screenshot_on_error: false)
    end

    define_method("#{element_name}_when_not_present") do |options = {}|
      opts = options_parser(options, timeout: 20)
      wait_for_element_does_not_exist(locator, timeout: opts[:timeout], screenshot_on_error: false)
    end

    define_method("touch_#{element_name}") do |options = {}|
      puts "touching #{element_name}" if DEBUG_LOGGING
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)
      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      touch(locator)
    end

    define_method("input_#{element_name}") do |value, options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      clear_text_in(locator)
      enter_text(locator, value)
    end

    define_method("check_#{element_name}") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      query("#{locator}", :setChecked => true)
    end

    define_method("uncheck_#{element_name}") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      query("#{locator}", :setChecked => false)
    end

    define_method("#{element_name}_is_checked?") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      query("#{locator}", :isChecked)
    end

    define_method("get_text_#{element_name}") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
      query("#{locator}", :text)[0]
    end

    define_method("look_for_#{element_name}") do |options = {}|
      opts = options_parser(options, timeout: 1, parent: nil, webview: false)

      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
    end

    define_method("#{element_name}_is_present?") do |options = {}|
      opts = options_parser(options, timeout: 1)
      puts "waiting #{opts[:timeout]} seconds for element #{element_name}" if DEBUG_LOGGING

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

    def find(element_name, timeout, parent, webview)
      puts "Looking for #{element_name} with an initial delay of #{timeout} seconds" if DEBUG_LOGGING
      return true if send("#{element_name}_is_present?", timeout: timeout)
      parent == "webview css:'*'" if webview # if looking for an element in a webview, the scroll parent is now a webview selector
      element_present = false
      puts 'Element has not been found within this timeout. Scrolling...' if DEBUG_LOGGING
      webview ? current_screen_state = query("webview css:'*'") : current_screen_state = query('*')
      prev_screen_state = []
      while !element_present && current_screen_state != prev_screen_state
        prev_screen_state = current_screen_state
        if parent.nil?
          begin
            puts 'Scrolling down normally' if DEBUG_LOGGING
            scroll_down
          rescue
            puts 'View is not scrollable, no biggie'
          end
        else
          puts "scrolling down parent #{parent}" if DEBUG_LOGGING
          scroll(parent, :down)
        end
        sleep 2
        element_present = send("#{element_name}_is_present?")
        puts "Element_present = #{element_present}" if DEBUG_LOGGING
        webview ? current_screen_state = query("webview css:'*'") : current_screen_state = query('*')
        puts 'I reckon I have scrolled to the bottom of the screen' if current_screen_state == prev_screen_state && DEBUG_LOGGING
        puts "I haven't scrolled to the bottom of the screen yet, I should retry now" if current_screen_state != prev_screen_state && DEBUG_LOGGING
      end
      puts "Element '#{element_name}' not found with an initial search delay of '#{timeout}'" if DEBUG_LOGGING
      element_present
    end
  end
end
