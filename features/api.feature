Feature: Test

Scenario: Creating a page object for android
  Given I have a page object defined
  And that page object has an element defined
  When I instantiate that page object
  Then it should have methods defined for that element