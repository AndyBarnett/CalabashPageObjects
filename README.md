#CalabashPageObjects
=====================

The Calabash Page Object ruby gem provides a way to define on-screen elements in your application. These elements then have methods defined to make interacting with them in a Calabash test framework easier and more consistent across iOS and Android.

The methods can be used whether the application is on iOS or Android.

Defining an element in Android `AElement.new` (or `IElement.new` for iOS) will provide you with methods to wait for that element, find it with or without scrolling, click it, retrieve properties etc. Using the gem takes away the headache of having cater for scrolling depending on screen size, dealing with several scrollviews and interacting with elements inside webviews.

#Getting Started

##Installing the gem
```
gem install 'CalabashPageObjects'
```
or add the following to your Gemfile if you use Bundler:
```
gem 'CalabashPageObjects'
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
require 'CalabashPageObjects'
class HomeScreen

  def initialize
    @my_element = AElement.new("* id:'search_button'")
  end
...
```

###iOS
To define elements for an iOS app:
```
require 'CalabashPageObjects'
class HomeScreen

  def initialize
    @my_element = IElement.new("* id:'search_button'")
  end
...
```

#Methods

Both AElement and IElement have the same methods. All of the methods take options as a hash. However, many of the methods have defaults set for some of their arguments and in many cases these won't need to be changed.

Some examples:

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

#####Shorthand
As in most cases, the only default that will be overridden is the timeout. There is a shorthand implemented especially for doing this. If the only argument passed in is an integer or float, then it is assumed that it is a timeout and all other arguments are left as default:
`@my_element.prod(10)`

###Parent elements
Most of the generated methods contain optional functionality to search the screen for your element.  This is useful in cases where your element may not be visible on the screen.  By default, Calabash scrolls down the first scrollable view in the hierarchy to look for your element, which isn't always the required behaviour.  In these cases, it is necessary to specify the parent element that you want to scroll through to find your element.

For example the 'prod' method will scroll through the screen to find your element and then tap it.  To make Calabash scroll through a specific scrollable view you can pass a Calabash query string locator for that scroll view element as an argument.

`@my_element.prod(parent: "* id:'my_list_container'")`

However, it is not good practice to use hardcoded strings any more than necessary.  To assist with this, a 'locator' attritute is provided to return the Calabash query string for an element.  This means that the parent element that you want to scroll through can be defined in the same way as all of your other elements.

e.g.
```
require 'CalabashPageObjects'
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

#Methods (for iOS and Android)

###screen_query
Queries the current screen using the elements locator.
This will return an array of hashes of each element on the screen that matches your locator. This is useful for counting objects with @my_element.screen_query.size, or you can delve further into an element's attributes.
```
@my_element.screen_query
```

###when_visible
Waits for an element to be present.
Can take an argument for timeout. Default is 10 seconds to wait until the element is present. As soon as it is present, the method will return.
Use this method to make sure a particular screen/element has loaded before continuing the test run. See 'present?' below for assertions.
```
@my_element.when_visible(30)
```

###when_not_visible
Does the opposite of when_visible. It will wait a full 10 seconds for the element to not be on the screen, unless you pass in your own timeout.

```
@my_element.when_not_visible(30)
```
###present?
Checks to see if the element is present. Returns a boolean. Can optionally scroll in search of the element.
Can take an argument for timeout. Default is 0.1. The method will wait this many seconds for the element to be present on the screen.
Can take an argument for parent. Default is nil
Can take an argument for webview. Default is false
Can take an argument for scroll. Default is false. If scroll is set to true, the method will wait 'timeout' seconds for the element to be present, and if it is not, it will automatically start scrolling to find it. It will return true if the element is found during this time, and it will return false if it has reached the bottom of the screen and it hasn't found the element anywhere.

```
@my_element.present?(timeout: 2, scroll: true)
```

###prod
This is probably the method you'll use the most. It is our method for tapping the element. We made sure that we used new methods names so that you can still use the regular Calabash Operations methods as well as ours.

Can take an argument for timeout.  Default is 1 second. It will wait this long for an element to be present before scrolling to find it. The beauty of this method is you can now both wait for an element to be present and tap it using the same method. Just include a float for however long you want to wait for it as the timout!
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.

```
@my_element.prod
```

###input
Clears the text in an element and then enters the text that is passed in.
Always takes a string argument for 'value'. This is the text you want to enter. It should be the first parameter passed in.
Can take an argument for timeout. Default is 1 second. Works in the same way as the 'prod' method.
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.

```
@my_element.input('email@email.com', parent: @form_scrollview)
```

###check
Sets a checkbox element to 'checked' state.
Can take an argument for timeout.  Default is 1 second. Will scroll to find it after this timeout has elapsed.
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.

```
@my_checkbox.check
```

###uncheck
Works in the same way as 'check' except sets the state of the checkbox to 'unchecked'.

```
@my_checkbox.uncheck
```

###checked?
Finds the checked status of a checkbox element. Returns true if it's checked and false if it's unchecked.
Can take an argument for timeout.  Default is 1 second. Will scroll to find it after this timeout has elapsed.
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.

```
@my_checkbox.checked?
```

###text
Retrieves the text attribute of an element and returns it as a string.
Can take an argument for timeout. Default is 1 second. Will scroll to find it after this timeout has elapsed.
Can take an argument for parent. Default is nil.
Can take an argument for webview. Default is false.

```
@my_element.text
```
