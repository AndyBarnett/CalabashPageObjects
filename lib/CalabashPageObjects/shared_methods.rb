class SharedMethods
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
        puts "scrolling down parent #{parent}" if CPO_LOGGING
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
end
