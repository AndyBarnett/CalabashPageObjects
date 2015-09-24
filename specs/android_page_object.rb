require 'CalabashPageObjects'
class AndroidPageObjectClass < CalabashAndroidBase
  element(:test_element, 'test locator')

  @my_element = SharedMethods.new("* text:'ggg'")

  def do_a_thing
    @my_element.locator
  end
end