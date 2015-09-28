require 'calabash-cucumber'
require 'calabash-cucumber/ibase'
require 'calabash-cucumber/core'
require_relative 'shared_methods'
# iOS base class.
class CalabashIosBase < Calabash::IBase
  @wait_error = Calabash::Cucumber::WaitHelpers::WaitError
end
