#calabash-page-objects
=====================

An internal repo for the calabash page object gem

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
