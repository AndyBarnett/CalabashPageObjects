class AElement < Element
  include Calabash::Android::WaitHelpers
  include Calabash::Android::Operations

  def initialize(*args)
    @wait_error = Calabash::Android::WaitHelpers::WaitError
    super(*args)
  end
end
