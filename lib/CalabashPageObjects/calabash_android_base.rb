require 'calabash-android'
require 'calabash-android/abase'
require 'calabash-android/operations'
require_relative 'shared_methods'
class CalabashAndroidBase < Calabash::ABase
  extend SharedMethods
  @wait_error = Calabash::Android::WaitHelpers::WaitError
end
