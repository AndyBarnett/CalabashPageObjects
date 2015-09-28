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
end
