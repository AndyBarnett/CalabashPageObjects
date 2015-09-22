module SharedMethods
  # rubocop:disable CyclomaticComplexity
  # rubocop:disable PerceivedComplexity
  # rubocop:disable AbcSize
  # rubocop:disable NestedMethodDefinition
  CPO_LOGGING ||= false

  def options_parser(input_options, defaults = {})
    if input_options.is_a?(Integer)
      timeout_only_output_options = {}
      timeout_only_output_options[:timeout] = input_options
      timeout_only_output_options
    else
      defaults.merge(input_options)
    end
  end

  def find(element_name, timeout, parent, webview)
    puts "Looking for #{element_name} with an initial delay of #{timeout} seconds." if CPO_LOGGING
    return true if send("#{element_name}_present?", timeout: timeout)

    parent = "webview css:'*'" if webview # if looking for an element in a webview, the scroll parent is now a webview selector
    puts 'Element has not been found within this timeout. Scrolling...' if CPO_LOGGING

    element_present = false
    webview ? current_screen_state = query("webview css:'*'") : current_screen_state = query('*')
    prev_screen_state = []

    while !element_present && current_screen_state != prev_screen_state
      prev_screen_state = current_screen_state

      if parent.nil?
        begin
          puts 'Scrolling down normally' if CPO_LOGGING
          scroll_down
        rescue
          puts "View is not currently scrollable after a wait of #{timeout}"
        end
      else
        puts "Scrolling down parent #{parent}" if CPO_LOGGING
        scroll(Send('parent_locator'), :down)
      end

      sleep 1
      element_present = send("#{element_name}_present?")
      puts "Is element present? => #{element_present}" if CPO_LOGGING

      webview ? current_screen_state = query("webview css:'*'") : current_screen_state = query('*')
      puts 'Have reached the bottom of the screen.' if current_screen_state == prev_screen_state && CPO_LOGGING
      puts 'Have not reached the bottom of the screen.  Retrying.' if current_screen_state != prev_screen_state && CPO_LOGGING
    end

    element_present
  end

  def element(element_name, locator)
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
      opts = options_parser(options, timeout: 0, parent: nil, webview: false)
      find(element_name, opts[:timeout], opts[:parent], opts[:webview])
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
        fail @wait_error, "Timeout waiting for elements: #{locator}"
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
