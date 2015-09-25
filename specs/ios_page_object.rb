require 'CalabashPageObjects'
# Test ios page object.
class IosPageObjectClass < CalabashIosBase
  element(:test_element, 'test locator')
end
