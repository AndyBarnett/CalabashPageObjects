#calabash-page-objects
=====================
An internal repo for the calabash page object gem.

The calabash page object gem has two base classes that can be inherited by your page objects to provide you with stock methods for your defined elements.  One is for iOS, the other is for android.

For example defining an element using calabashpageobjects `element` method will provide you with methods to wait for the element, click the element, retrieve some properties of the element etc.

#Using the base classes

To use the gem from the internal gem server add

`source 'http://gems.ict.je-labs.com:8808'`
to the top of your gemfile and add

`gem 'calabashpageobjects'`

##Android
To use the android framework, have your page objects require calabash-android first, then the framework, then have the page object inherit the android base class.
```
require 'calabash-android'
require 'CalabashPageObjects'
class PageObjectClass < CalabashAndroidBase
```
##iOS
To use the iOS framework, have your page objects require calabash-cucumber first, then the framework, then have the page object inherit the ios base class.
```
require 'calabash-cucumber'
require 'CalabashPageObjects'
class PageObjectClass < CalabashIosBase
```

#Declaring elements

After defining an element with a unique name and a calabash query string that returns the element, the gem generates methods for interacting with that element.  Usage:

`element(:element_name, "* text:'Hello'")`

#Methods 
Before discussing the methods that are generated by the element method there are a few concepts to understand.

##Key concepts
###Parent Elements
Most of the generated methods contain optional functionality to search the screen for your element.  This is useful in cases where your element may not be visible on the screen.  By default calabash scrolls down the first scrollable element that it finds, which isn't always the required functionality.  In these cases it is necessary to specify the parent element that you want to scroll through to find your element.

For example the `touch_ELEMENT_NAME` method will scroll through the screen to find your element and then tap it.  To make calabash scroll through a non default scrollable view you can pass a calabash query string as an argument.

`touch_ELEMENT_NAME(parent: action_bar_locator)`

In this case, rather than passing in the calabash locator as a hardcodedn string, the ELEMENT_NAME_locator method has been used.  This will be discussed below, but a quick justification would be to say that it is best parctice not to have hardcoded strings strewn througout your page objects.  Instead, it is better to define the parent object like any other element and use the ELEMENT_NAME_locator method to return the string.

###Arguments
All of the generated methods take options as a hash.  Many of the methods that are generated have defaults set for some of their arguments, as in many cases these don't need to be changed.  To override these arguments and to pass in other arguments, parameters are supplied as a hash. Some examples:

The method ELEMENT_NAME_text can accept values for the timeout for the element to appear, whether the element you want is inside a parent element and whether the element is in a webview.  The defaults for these values are as follows

timeout: 1
parent: nil
webview: false

so to run the method for an element that should be visible inside of 1 second, that is not inside a parent element and is not inside a webview, the defaults can be used.

`ELEMENT_NAME_text`

but to run the method for an element that should be present inside of 10 seconds and is in a webview some defaults need to be overridden.

`ELEMENT_NAME_text({timeout: 10, webview: true})`

####Shorthand
As for many screens the only argument passed to most methods will be a timeout, there is a shorthand for passing in only a timeout to  method.  If the only argument passed in is an integer, then it is assumed that it is a timeout and all other arguments are left as default.

So to run the ELEMENT_NAME_text method with defaults values for whether the element is in a webview, or inside a parent element, but to extend the timeout from the default of 1 second to 15 seconds you can call
`ELEMENT_NAME_text(15)`
which is equivalent to 
`ELEMENT_NAME_text(timeout:15)`

#####element_name_when_present
#####element_name_when_not_present
#####element_name_is_present?
#####touch_element_name
#####input_element_name
#####check_element_name
#####uncheck_element_name
#####element_name_is_checked?
#####get_text_element_name
#####look_for_element_name
#####element_name_locator


