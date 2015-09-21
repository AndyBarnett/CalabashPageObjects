require 'calabash-android'
require 'CalabashPageObjects'
class AndroidPageObjectClass < CalabashAndroidBase
  element(:test_element, "test locator")
end