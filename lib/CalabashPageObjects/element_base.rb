require_relative 'element_base_option_parser'
require_relative 'element_finder'
# The main class for functionality for defined elements.
class ElementBase
  include ElementBaseOptionParser
  include ElementFinder

  attr_reader :locator

  CPO_LOGGING ||= false

  # Constructor for ElementBase.
  # Takes an argument for the Calabash Query that locates the object.
  def initialize(locator)
    @locator = locator
  end

  # Queries the current screen using the elements locator.
  def screen_query
    query("#{@locator}")
  end

  # Waits for an element to be visible on the current screen.
  # Can take an argument for timeout. Default is 10 seconds.
  def when_visible(options = {})
    opts = options_parser(options, timeout: 10)
    puts "Waiting for element with locator #{@locator} to appear..." if CPO_LOGGING
    wait_for_element_exists(@locator, timeout: opts[:timeout], screenshot_on_error: false)
  end

  # Waits for an element to not be visible on the current screen.
  # Can take an argument for timeout. Default is 10 seconds.
  def when_not_visible(options = {})
    opts = options_parser(options, timeout: 10)
    puts "Waiting for element with locator #{@locator} to not be present..." if CPO_LOGGING
    wait_for_element_does_not_exist(@locator, timeout: opts[:timeout], screenshot_on_error: false)
  end

  # Checks to see if the element is present. Can optionally scroll down to try and find the element.
  # Can take an argument for timeout. Default is 0.5 as 0 can cause calabash to hang.
  # Can take an argument for parent. Default is nil
  # Can take an argument for webview. Default is false
  # Can take an argument for scroll. Default is false
  def present?(options = {})
    opts = options_parser(options, timeout: 0.5, parent: nil, webview: false, scroll: false)
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
  # Can take an argument for timeout. Default is 1 second
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def prod(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)
    find(opts[:timeout], opts[:parent], opts[:webview])
    sleep 0.1
    puts "Touching an element with locator #{@locator}." if CPO_LOGGING
    touch(@locator)
  end

  # Clears the text in an element and then enters the text that is passed into the method.
  # Always takes an argument for 'value'.
  # Can take an argument for timeout. Default is 1 second.
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

  # Set a checkbox element to 'checked' state.
  # Can take an argument for timeout. Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def check(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)

    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Setting checkbox with locator #{@locator} to checked..." if CPO_LOGGING
    query("#{@locator}", setChecked: true)
  end

  # Set a checkbox element to 'unchecked' state.
  # Can take an argument for timeout. Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def uncheck(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)

    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Setting checkbox with locator #{@locator} to unchecked..." if CPO_LOGGING
    query("#{@locator}", setChecked: false)
  end

  # Find the checked status of a checkbox element.
  # Can take an argument for timeout. Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def checked?(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)

    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Checking status of checkbox element with locator #{@locator}." if CPO_LOGGING
    query("#{@locator}", :isChecked)[0]
  end

  # Retrieve the text attribute of an element.
  # Can take an argument for timeout. Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def text(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)

    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Retrieving text from element with locator #{@locator}..." if CPO_LOGGING
    query("#{@locator}", :text)[0]
  end

  # Search the whole screen for an element, scrolling down if it doesn't find it after the timeout.
  # Can take an argument for timeout. Default is 1 second.
  # Can take an argument for parent. Default is nil.
  # Can take an argument for webview. Default is false.
  def look_for(options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)
    fail @wait_error, "Timeout waiting for element with locator #{@locator}" unless find(opts[:timeout], opts[:parent], opts[:webview])
  end
end
