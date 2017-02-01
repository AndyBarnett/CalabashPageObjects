#calabash-page-objects

##Automatic waiting for element presence:
No more lines of code waiting for an element to be present before clicking it.

##Automatic scrolling:
The size of the phone no longer matters! If your element isn't immediately present, CPO will scroll to find it for you, and stop when it reaches the bottom of the view.

##Easy declaration of hierarchical parent views:
Specify the correct list view or webview container that the element lives in as a simple parameter, so CPO knows which one to scroll to find your element.

#Overview
The Calabash Page Object ruby gem provides a way to define on-screen elements in your application. These elements then have methods defined to make interacting with them in a Calabash test framework easier and more consistent across iOS and Android.

The methods can be used whether the application is on iOS or Android.

Defining an element in Android `AElement.new` (or `IElement.new` for iOS) will provide you with methods to wait for that element, find it with or without scrolling, click it, retrieve properties etc. Using the gem takes away the headache of having cater for scrolling depending on screen size, dealing with several scrollviews and interacting with elements inside webviews.

#Getting Started

##Installing the gem
[![Gem Version](https://badge.fury.io/rb/calabash-page-objects.svg)](https://badge.fury.io/rb/calabash-page-objects)
```
gem install 'calabash-page-objects'
```
or add the following to your Gemfile if you use Bundler:
```
gem 'calabash-page-objects'
```
Then require it in your page object class:
```
require 'CalabashPageObjects'
```

##Defining Elements

There are two different types of element made available in the gem, IElement (for iOS apps) and AElement (for Android apps). These two classes provide exactly the same functionality, but abstract away slight differences in implementation between the platforms.

The constructors of both classes take a Calabash query string as their only argument. More information about the Calabash query syntax can be found [here](https://github.com/calabash/calabash-android/wiki/05-Query-Syntax).

###For Android:
To define elements for an Android app:
```
require 'calabash-page-objects'
class HomeScreen

  def initialize
    @my_element = AElement.new("* id:'search_button'")
  end
...
```

###iOS
To define elements for an iOS app:
```
require 'calabash-page-objects'
class HomeScreen

  def initialize
    @my_element = IElement.new("* id:'search_button'")
  end
...
```

#Methods (for iOS and Android)

Both AElement and IElement have the same methods. All of the methods take options as a hash. However, many of the methods have defaults set for some of their arguments and in many cases these won't need to be changed.

###screen_query
Queries the current screen using the elements locator.
This will return an array of hashes of each element on the screen that matches your locator. This is useful for counting objects with @my_element.screen_query.size, or you can delve further into an element's attributes.

#####Example
```
@my_element.screen_query
```

###when_visible
Waits a number of seconds for the element to be present. As soon as it is, the method will return.
#####Args
```
Can take an argument for timeout. Default is 10 seconds.
```

#####Example
```
@my_element.when_visible(30)
```
Use this method to make sure a particular screen/element has loaded before continuing the test run. See 'present?' if you want to assert on the presence of an element.

###when_not_visible
Will wait a full amount of seconds for the element to not be on the screen.
#####Args
```
Can take an argument for timeout. Default is 10 seconds.
```

#####Example
```
@my_element.when_not_visible(30)
```

###present?
Checks to see if the element is present. Returns a boolean. Can optionally scroll in search of the element.
#####Args
```
Can take an argument for timeout. Default is 0.1.
Can take an argument for parent. Default is nil
Can take an argument for webview. Default is false
Can take an argument for scroll. Default is false. 
```

#####Example
```
@my_element.present?(timeout: 2, scroll: true)
```
The method will wait 'timeout' seconds for the element to be present on the screen. If 'scroll' is set to true, the method will wait 'timeout' seconds for the element to be present, and if it is not, it will automatically start scrolling to find it. It will return true if the element is found during this time and it will return false if it has reached the bottom of the screen and it hasn't found the element anywhere.

###prod
This is probably the method you'll use the most. It is our method for tapping the element. We made sure that we used new methods names so that you can still use the regular Calabash Operations methods as well as ours.
#####Args
```
Can take an argument for timeout.  Default is 1 second. 
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.
```

#####Example
```
@my_element.prod
```
It will wait 'timeout' seconds for an element to be present before scrolling to find it. The beauty of this method is you can now both wait for an element to be present and tap it using the same method. Just include an integer or float for however long you want to wait for it as the timeout!

###input
Clears the text in an element and then enters the text that is passed in.
#####Args
```
Always takes a string argument for 'value'. 
Can take an argument for timeout. Default is 1 second. Works in the same way as the 'prod' method.
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.
```
Value is is the text you want to enter. It should be the first parameter passed in.

#####Example
```
@my_element.input('email@email.com', parent: @form_scrollview)
```

###check
Sets a checkbox element to 'checked' state.
#####Args
```
Can take an argument for timeout. Default is 1 second.
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.
```

#####Example
```
@my_checkbox.check
```
Will scroll to find the element after the timeout has elapsed.

###uncheck
Works in the same way as 'check' except sets the state of the checkbox to 'unchecked'.
#####Args
```
Can take an argument for timeout. Default is 1 second.
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.
```

#####Example
```
@my_checkbox.uncheck
```
Will scroll to find the element after the timeout has elapsed.

###checked?
Finds the checked status of a checkbox element. Returns true if it's checked and false if it's unchecked.

#####Args
```
Can take an argument for timeout.  Default is 1 second.
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.
```

#####Example
```
@my_checkbox.checked?
```
Will scroll to find the element after the timeout has elapsed.

###text
Retrieves the text attribute of an element and returns it as a string.

#####Args
```
Can take an argument for timeout. Default is 1 second.
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.
```

#####Example
```
@my_element.text
```
Will scroll to find the element after the timeout has elapsed.

#Parameter usage
###Some examples:

The AElement @my_element has a method called 'prod' which will tap it. It can accept values for the timeout for the element to appear, a secondary 'parent' element that your element lives inside, and whether the element is in a webview. The defaults for these values are as follows:
```
timeout: 1
parent: nil
webview: false
```
so if the defaults are suitable then the prod method can be called with no arguments:
`@my_element.prod`

but to run the method in a situation where the defaults are not suitable, you can override as many as you like. In this example we override timeout and webview, but not parent:
`@my_element.prod(timeout: 10, webview: true)`

###Shorthand for timeout
As in most cases, the only default that will be overridden is the timeout. There is a shorthand implemented especially for doing this. If the only argument passed in is an integer or float, then it is assumed that it is a timeout and all other arguments are left as default:
`@my_element.prod(10)`

###Parent elements
Most of the generated methods contain optional functionality to search the screen for your element.  This is useful in cases where your element may not be visible on the screen.  By default, Calabash scrolls down the first scrollable view in the hierarchy to look for your element, which isn't always the required behaviour.  In these cases, it is necessary to specify the parent element that you want to scroll through to find your element.

For example the 'prod' method will scroll through the screen to find your element and then tap it.  To make Calabash scroll through a specific scrollable view you can pass a Calabash query string locator for that scroll view element as an argument.

`@my_element.prod(parent: "* id:'my_list_container'")`

However, it is not good practice to use hardcoded strings any more than necessary.  To assist with this, a 'locator' attritute is provided to return the Calabash query string for an element.  This means that the parent element that you want to scroll through can be defined in the same way as all of your other elements.
 
e.g.
```
require 'calabash-page-objects'
class PageObjectClass

  def initialize
    @my_element = IElement.new("* id:'search_button'")
    @my_parent_element = IElement.new("* id:'my_list_container'")
  end
  
  def tap_my_element
    @my_element.prod(parent: @my_parent_element.locator)
  end
...
```
Note: passing in an element for 'parent' rather than its locator will not work at present.
