#calabash-page-objects
=====================

The calabash page object gem provides a way to define on-screen elements in your application. These elements then have methods defined to make interacting with them easier and more consistent across iOS and Android.

The methods can be used whether the application is on iOS or Android.

For example, defining an element in Android `AElement.new` (or `IElement.new` for iOS) will provide you with methods to wait for that element, find it with or without scrolling, click it, retrieve properties etc. Using the gem takes away the headache of having cater for scrolling depending on screen size, dealing with several scrollviews and interacting with elements inside webviews.

#Getting Started

##Installing the gem
```
gem install 'CalabashPageObjects'
```
or add the following to your Gemfile if you use Bundler:
```
gem 'CalabashPageObjects'
```

##Defining Elements

There are two different types of element made available in the gem, IElement (for iOS apps) and AElement (for Android apps).  These two classes provide exactly the same functionality, but abstract away slight differences in implementation between the platforms.

The constructors of both classes take a Calabash query string as their only argument. More information about the Calabash query syntax can be found [here](https://github.com/calabash/calabash-android/wiki/05-Query-Syntax).

###For Android:
To define elements for an Android app:
```
require 'CalabashPageObjects'
class PageObjectClass

  def initialize
    @my_element = AElement.new("* text:'calabash-locator'")
  end
...
```

###iOS
To define elements for an iOS app:
```
require 'CalabashPageObjects'
class PageObjectClass

  def initialize
    @my_element = IElement.new("* text:'calabash-locator'")
  end
...
```

#Methods

Both AElement and IElement have the same methods.  All of the methods take options as a hash.  However, many of the methods have defaults set for some of their arguments and in many cases these won't need to be changed.

Some examples:

The AElement @my_element has a method called 'prod' which will tap it.  It can accept values for the timeout for the element to appear, whether the element you want is inside a parent element and whether the element is in a webview. The defaults for these values are as follows
```
timeout: 1
parent: nil
webview: false
```
so if the defaults are suitable then the prod method can be called with no arguments.

`@my_element.prod`

but to run the method in a situation where the defaults are not suitable they can be overridden as follows.

`@my_element.prod(timeout: 10, webview: true)`

#####Shorthand
As in most cases the only default overridden will be a timeout there is a shorthad for doing this.  If the only argument passed in is an integer or float, then it is assumed that it is a timeout and all other arguments are left as default.

###Parent elements
Most of the generated methods contain optional functionality to search the screen for your element.  This is useful in cases where your element may not be visible on the screen.  By default Calabash scrolls down the first scrollable view in the hierarchy, which isn't always the required behaviour.  In these cases it is necessary to specify the parent element that you want to scroll through to find your element.

For example the 'prod' method will scroll through the screen to find your element and then tap it.  To make Calabash scroll through a specific scrollable view you can pass a Calabash query string locator for that scroll view element as an argument.

`@my_element.prod(parent: "* text:'a locator'")`

However, it is not good practice to use hard coded strings any more than necessary.  To assist with this, a 'locator' attritube is provided to return the Calabash query string for an element.  This means that the parent element that you want to scroll through can be defined in the same way as all of your other elements.

e.g.
```
require 'CalabashPageObjects'
class PageObjectClass

  def initialize
    @my_element = IElement.new("* text:'calabash-locator'")
    @my_parent_element = IElement.new("* id:'scroll view id'")
  end
  
  def tap_my_element
    @my_element.prod(parent: @my_parent_element.locator)
  end
...
```

###Methods (for iOS and Android)

####element_name_when_present
Waits for an element to be present on the screen.
######Args
Can take an argument for `timeout`.  Default is 10 seconds.

####element_name_when_not_present
Waits for an element to not be present.
######Args
Can take an argument for `timeout`.  Default is 10 seconds.

####element_name_is_present?
Checks to see is an element is present on the screen and returns a boolean value.

This method will scroll through the screen to try to locate your element if it isn't visible at the end of the timeout.
######Args
Can take an argument for `timeout`.  Default is 0 second.
Can take an argument for `parent`. Default is nil.
Can take an argument for `webview`. Default is false.

####touch_element_name
This method taps the element.

This method will scroll through the screen to try to locate your element if it isn't visible at the end of the timeout.
######Args
Can take an argument for `timeout`.  Default is 1 second.
Can take an argument for `parent`. Default is nil.
Can take an argument for `webview`. Default is false.

####input_element_name
This method clears the text in an element and then enters the text that is passed in.

This method will scroll through the screen to try to locate your element if it isn't visible at the end of the timeout.
######Args
Always takes an argument for the `value` to enter into the element.
Can take an argument for `timeout`.  Default is 1 second.
Can take an argument for `parent`. Default is nil.
Can take an argument for `webview`. Default is false.
#####Examples
`input_element_name('My string')` if you want to use the default options.
`input_element_name('My string', {timeout: 15, webview: true})` if you want to override the defaults.

####check_element_name
This method will check a checkbox element.

This method will scroll through the screen to try to locate your element if it isn't visible at the end of the timeout.
######Args
Can take an argument for `timeout`.  Default is 1 second.
Can take an argument for `parent`. Default is nil.
Can take an argument for `webview`. Default is false.
####uncheck_element_name
This method will uncheck a checkbox element.

This method will scroll through the screen to try to locate your element if it isn't visible at the end of the timeout.
######Args
Can take an argument for `timeout`.  Default is 1 second.
Can take an argument for `parent`. Default is nil.
Can take an argument for `webview`. Default is false.

####element_name_is_checked?
This method will look to see is a checkbox element is checked or not and return a boolean.

This method will scroll through the screen to try to locate your element if it isn't visible at the end of the timeout.
######Args
Can take an argument for `timeout`.  Default is 1 second.
Can take an argument for `parent`. Default is nil.
Can take an argument for `webview`. Default is false.

####element_name_text
This method retrieve the text attribute of an element.

This method will scroll through the screen to try to locate your element if it isn't visible at the end of the timeout.
######Args
Can take an argument for `timeout`.  Default is 1 second.
Can take an argument for `parent`. Default is nil.
Can take an argument for `webview`. Default is false.

####look_for_element_name
This method looks through a screen to find an element.  By definition this method will scroll through the screen to try to locate your element if it isn't visible at the end of the timeout.
######Args
Can take an argument for `timeout`.  Default is 1 second.
Can take an argument for `parent`. Default is nil.
Can take an argument for `webview`. Default is false.

####element_name_locator
Will return the calabash query string that was provided when the element was defined.
######Args
This method doesn't take any options.

##Logging
If a constant called `CPO_LOGGING` has been set to true, additional logging information will be printed to the console as methods are being executed.  By default it is initialised to false.
