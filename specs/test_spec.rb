require 'rspec'
require 'rspec/expectations'
require_relative 'android_page_object'
require_relative 'ios_page_object'
include RSpec
extend RSpec::Matchers

RSpec.describe calabash-page-objects do
  it 'android has inherited methods' do
    android_page_object = AndroidPageObjectClass.new
    android_page_object.try_all_methods
  end

  it 'ios has inherited methods' do
    ios_page_object = IosPageObjectClass.new
    ios_page_object.try_all_methods
  end
end
