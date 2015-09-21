require 'rspec'
require 'rspec/expectations'
require_relative 'android_page_object'
require_relative 'ios_page_object'
include RSpec
extend RSpec::Matchers

RSpec.describe CalabashPageObjects do
  it 'android has inherited methods' do
    android_page_object = AndroidPageObjectClass.new(self)
    methods = android_page_object.methods
    expect(methods).to include(:test_element_when_present)
    expect(methods).to include(:test_element_when_present)
    expect(methods).to include(:test_element_when_not_present)
    expect(methods).to include(:touch_test_element)
    expect(methods).to include(:input_test_element)
    expect(methods).to include(:check_test_element)
    expect(methods).to include(:uncheck_test_element)
    expect(methods).to include(:test_element_checked?)
    expect(methods).to include(:test_element_text)
    expect(methods).to include(:test_element_look_for)
    expect(methods).to include(:test_element_locator)
  end

  it 'ios has inherited methods' do
    ios_page_object = IosPageObjectClass.new(self)
    methods = ios_page_object.methods
    expect(methods).to include(:test_element_when_present)
    expect(methods).to include(:test_element_when_present)
    expect(methods).to include(:test_element_when_not_present)
    expect(methods).to include(:touch_test_element)
    expect(methods).to include(:input_test_element)
    expect(methods).to include(:check_test_element)
    expect(methods).to include(:uncheck_test_element)
    expect(methods).to include(:test_element_checked?)
    expect(methods).to include(:test_element_text)
    expect(methods).to include(:test_element_look_for)
    expect(methods).to include(:test_element_locator)
  end
end
