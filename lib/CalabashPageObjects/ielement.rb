class IElement < Element
  include Calabash::Cucumber::Core
  include Calabash::Cucumber::WaitHelpers
  def initialize(*args)
    @wait_error = Calabash::Cucumber::WaitHelpers::WaitError
    super(*args)
  end

  # Need to override the method in the Element class as this one has a weird name in the iOS libs.
  # Waits for an element to not be present.
  # Can take an argument for timeout. Default is 10 seconds.
  def when_not_present(options = {})
    opts = options_parser(options, timeout: 10)
    puts "Waiting for element with locator #{@locator} to not be present..." if CPO_LOGGING
    wait_for_element_does_not_exists(@locator, timeout: opts[:timeout], screenshot_on_error: false)
  end
end