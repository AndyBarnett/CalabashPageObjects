require 'rspec'
require 'rspec/expectations'
require 'calabash-android'
require_relative 'page_object'
include RSpec
extend RSpec::Matchers

RSpec.describe CalabashPageObjects do
  before :all do
    @page_object = PageObjectClass.new(self)
  end

  it "has inherited methods" do
    methods = @page_object.methods
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