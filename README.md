#calabash-page-objects
=====================

An internal repo for the calabash page object gem.

After defining an element with a unique name and a calabash query string that returns the element, the gem generates methods for interacting with that element.

`element(:element_name, "* text:'element locator'")`

Will generate:

###element_name_when_present
###element_name_when_not_present
###element_name_is_present?
###touch_element_name
###input_element_name
###check_element_name
###uncheck_element_name
###element_name_is_checked?
###get_text_element_name
###look_for_element_name
###element_name_locator

To use the gem from the internal gem server add

source 'http://gems.ict.je-labs.com:8808'

to the top of your gemfile and add

gem 'calabashpageobjects'.

To use the android framework, have your page objects require calabash-android first, then the framework, then have the page object inherit the android base class.

require 'calabash-android'
require 'CalabashPageObjects'
class PageObjectClass < CalabashAndroidBase

To use the android framework, have your page objects require calabash-cucumber first, then the framework, then have the page object inherit the ios base class.
