# Provides a method that searches the screen for an element.
module ElementFinder
  CPO_LOGGING ||= false

  # Searches the screen for an element if it isn't visible after an initial delay.
  def find(initial_delay, parent, webview)
    puts "Looking for element with locator #{@locator} and an initial delay of #{initial_delay} seconds." if CPO_LOGGING
    return true if present?(initial_delay)

    puts 'Element has not been found within initial_delay.' if CPO_LOGGING
    element_present = false
    current_screen_state = query_screen(webview)
    prev_screen_state = []

    while !element_present && current_screen_state != prev_screen_state
      puts 'Element not found. Scrolling...' if CPO_LOGGING
      prev_screen_state = current_screen_state
      scroll_down_the_screen(parent, webview)
      current_screen_state = query_screen(webview)
      element_present = present?(0.4)
    end

    element_present
  end

  def query_screen(webview)
    webview ? current_screen_state = query("webview css:'*'") : current_screen_state = query('*')
    current_screen_state
  end

  def scroll_down_the_screen(parent, webview)
    if !parent.nil?
      puts "Scrolling down parent element - #{parent.locator}." if CPO_LOGGING
      scroll(parent.locator, :down)
    elsif webview
      puts "Scrolling down the default webview." if CPO_LOGGING
      scroll('webview', :down)
    else
      begin
        puts 'Scrolling down the default element.' if CPO_LOGGING
        scroll_down
      rescue
        puts 'View is not currently scrollable.'
      end
    end
  end

  private :find, :query_screen, :scroll_down_the_screen
end
