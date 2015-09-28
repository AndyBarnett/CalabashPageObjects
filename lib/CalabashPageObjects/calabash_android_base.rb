require 'calabash-android'
require 'calabash-android/abase'
require 'calabash-android/operations'
require 'calabash-android/wait_helpers'
require_relative 'shared_methods'
require 'CalabashPageObjects/shared_methods'
class CalabashAndroidBase < Calabash::ABase
  @wait_error = Calabash::Android::WaitHelpers::WaitError

end
