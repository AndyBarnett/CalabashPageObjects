calabash-page-objects
=====================

An internal repo for the calabash page object gem

After defining an element with a unique name and a calabash query string that returns the element, the gem generates methods for interacting with that element.

element(:some_element, "* text:'My element'")

Will generate
some_element_when_present
some_element_when_not_present
touch_some_element
input_some_element
check_some_element
uncheck_some_element
some_element_is_checked?
get_text_some_element
look_for_some_element
some_element_is_present?
some_element_locator
