require 'rspec'
require 'rspec/expectations'
require_relative 'android_page_object'
require_relative 'ios_page_object'
include RSpec
extend RSpec::Matchers

RSpec.describe CalabashPageObjects do
  it 'android has inherited methods' do
    android_page_object = AndroidPageObjectClass.new(self)
    android_page_object.try_all_methods
  end

  it 'ios has inherited methods' do
    ios_page_object = IosPageObjectClass.new(self)
    ios_page_object.try_all_methods
  end

  it 'old style android works' do
    old_android_style = OldAndroidPageObject.new(self)
    old_android_style.test_method
  end

  it 'old style ios works' do
    old_android_style = OldIosPageObject.new(self)
    old_android_style.test_method
  end
end
