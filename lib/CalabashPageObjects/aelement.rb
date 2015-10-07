# The android specific implementation of ElementBase.
class AElement < ElementBase
  include Calabash::Android::WaitHelpers
  include Calabash::Android::Operations

  def initialize(*args)
    @wait_error = Calabash::Android::WaitHelpers::WaitError
    super(*args)
  end
end
