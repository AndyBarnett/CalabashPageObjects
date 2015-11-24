# The ios specific implementation of ElementBase.
class IElement < ElementBase
  include Calabash::Cucumber::Core
  include Calabash::Cucumber::WaitHelpers
  include Calabash::Cucumber::KeyboardHelpers

  def initialize(*args)
    @wait_error = Calabash::Cucumber::WaitHelpers::WaitError
    super(*args)
  end

  # Need to override the method in the Element class as this one has a different name in the iOS libs.
  # Waits for an element to not be present.
  # Can take an argument for timeout. Default is 10 seconds.
  def when_not_visible(options = {})
    opts = options_parser(options, timeout: 10)
    puts "Waiting for element with locator #{@locator} to not be present..." if CPO_LOGGING
    wait_for_element_does_not_exists(@locator, timeout: opts[:timeout], screenshot_on_error: false)
  end

  # The ios libs have a different name for the method to clear the test from a field.
  def input(value, options = {})
    opts = options_parser(options, timeout: 1, parent: nil, webview: false)
    find(opts[:timeout], opts[:parent], opts[:webview])
    puts "Clearing text from element with locator #{@locator}..." if CPO_LOGGING
    clear_text(@locator)
    puts "Entering text in element with locator #{@locator}..." if CPO_LOGGING
    enter_text(@locator, value)
  end
end
