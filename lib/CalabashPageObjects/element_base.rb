require_relative 'element_base_option_parser'
require_relative 'element_finder'
# The main class for functionality for defined elements.
class ElementBase
  include ElementBaseOptionParser
  include ElementFinder

  attr_reader :locator

  CPO_LOGGING ||= false

  def initialize(locator)
    @locator = locator
    # How do I give this class access to the calabash methods so it can actually do stuff???
  end

  # Queries the current screen using the elements locator.
  def screen_query # need a proper name for this. It used to be just the name passed in..
    query("#{@locator}")
  end

  # Waits for an element to be present.
  # Can take an argument for initial_delay. Default is 10 seconds.
  def when_visible(options = {})
    opts = options_parser(options, timeout: 10)
    puts "Waiting for element with locator #{@locator} to appear..." if CPO_LOGGING
    wait_for_element_exists(@locator, timeout: opts[:timeout], screenshot_on_error: false)
  end

  # Waits for an element to not be present.
  # Can take an argument for initial_delay. Default is 10 seconds.
  def when_not_visible(options = {})
    opts = options_parser(options, timeout: 10)
    puts "Waiting for element with locator #{@locator} to not be present..." if CPO_LOGGING
    wait_for_element_does_not_exist(@locator, timeout: opts[:timeout], screenshot_on_error: false)
  end

  # Checks to see if the element is present.  Can scroll to find the element or not.
  # Can take an argument for initial_delay. Default is 0
  # Can take an argument for parent.  Default is nil
  # Can take an argument for webview.  Default is false
  # Can take an argument for scroll.  Default is false
  def present?(options = {})
    opts = options_parser(options, timeout: 0.1, parent: nil, webview: false, scroll: false)
    if opts[:scroll]
      find(opts[:timeout], opts[:parent], opts[:webview])
    else
      puts "Checking for the presence of an element with locator #{@locator} after #{opts[:timeout]} seconds..." if CPO_LOGGING
      begin
        wait_for_element_exists(@locator, timeout: opts[:timeout], screenshot_on_error: false)
        true
      rescue
        false
      end
    end
  end

  # Taps the element.
  # Can take an argument for initial_delay.  Default is 1 second
  # Can take an argument for parent.  Default is nil.
  # Can take an argument for webview.  Default is false.
  def prod(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)
    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Touching an element with locator #{@locator}." if CPO_LOGGING
    touch(@locator)
  end

  # Clears the text in an element and then enters the text that is passed in.
  # Always takes an argument for value.
  # Can take an argument for initial_delay.  Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def input(value, options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)
    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Clearing text from element with locator #{@locator}..." if CPO_LOGGING
    clear_text_in(@locator)
    puts "Entering text in element with locator #{@locator}..." if CPO_LOGGING
    enter_text(@locator, value)
  end

  # Check a checkbox element.
  # Can take an argument for initial_delay.  Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def check(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)

    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Setting checkbox with locator #{@locator} to checked..." if CPO_LOGGING
    query("#{@locator}", setChecked: true)
  end

  # Uncheck a checkbox element.
  # Can take an argument for initial_delay.  Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def uncheck(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)

    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Setting checkbox with locator #{@locator} to unchecked..." if CPO_LOGGING
    query("#{@locator}", setChecked: false)
  end

  # Find the checked status of a checkbox element.
  # Can take an argument for initial_delay.  Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def checked?(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)

    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Checking status of checkbox element with locator #{@locator}." if CPO_LOGGING
    query("#{@locator}", :isChecked)
  end

  # Retrieve the text attribute of an element.
  # Can take an argument for initial_delay.  Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def text(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)

    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Retrieving text from element with locator #{@locator}..." if CPO_LOGGING
    query("#{@locator}", :text)[0]
  end

  # Search the whole screen for an element.
  # Can take an argument for initial_delay.  Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def look_for(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)
    fail @wait_error, "Timeout waiting for element with locator #{@locator}" unless find(opts[:timeout], opts[:parent], opts[:webview])
  end
end
