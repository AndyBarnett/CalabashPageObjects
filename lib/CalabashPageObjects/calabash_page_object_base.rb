class CalabashPageObjectBase
  attr_accessor :world

  def initialize(world)
    self.world = world
  end

  protected
  def method_missing(name, *args, &block)
    if self.world == nil
      puts 'World has not been set in the base class.  Pleas check you have added super(world) to your page objects constructor.'
      throw ArgumentError
    end

    world.send(name, *args, &block)
  end
end
