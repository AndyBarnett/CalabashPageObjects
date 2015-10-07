# Provides a method that searches the screen for an element.
module ElementFinder
  CPO_LOGGING ||= false

  # Searches the screen for an element if it isn't visible after an initial delay.
  def find(initial_delay, parent, webview) # parent should be an element
    puts "Looking for element with locator #{@locator} and an initial delay of #{initial_delay} seconds." if CPO_LOGGING
    return true if present?(initial_delay)

    # if looking for an element in a webview, the scroll parent is now a webview selector
    parent = 'webview' if webview
    puts 'Element has not been found within this initial_delay. Scrolling...' if CPO_LOGGING

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
          puts "View is not currently scrollable after a wait of #{initial_delay}"
        end
      else
        puts "Scrolling down parent #{parent.locator}" if CPO_LOGGING
        # As we are using the parent variable here for webviews and other elements we need to check which is which.
        unless parent.is_a?(String)
          scroll(parent.locator, :down)
        else
          scroll(parent, :down)
        end
      end

      element_present = present?(0.4)
      puts "Is element present? => #{element_present}" if CPO_LOGGING

      webview ? current_screen_state = query("webview css:'*'") : current_screen_state = query('*')
      puts 'Have reached the bottom of the screen.' if current_screen_state == prev_screen_state && CPO_LOGGING
      puts 'Have not reached the bottom of the screen.  Retrying.' if current_screen_state != prev_screen_state && CPO_LOGGING
    end

    element_present
  end

  private :find
end
