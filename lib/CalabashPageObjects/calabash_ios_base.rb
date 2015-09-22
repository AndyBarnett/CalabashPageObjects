require 'calabash-cucumber'
require 'calabash-cucumber/ibase'
require 'calabash-cucumber/core'
require_relative 'shared_methods'
class CalabashIosBase < Calabash::IBase
  extend SharedMethods
  @wait_error = Calabash::Cucumber::WaitHelpers::WaitError
end
