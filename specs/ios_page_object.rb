require 'calabash-cucumber'
require 'CalabashPageObjects'
class IosPageObjectClass < CalabashIosBase
  element(:test_element, "test locator")
end