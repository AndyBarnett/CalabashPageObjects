require 'CalabashPageObjects'
class AndroidPageObjectClass < CalabashPageObjectBase
  def initialize(world)
    @my_element = AElement.new("* text:'ggg'")
    super(world)
  end

  def try_all_methods
    begin
      @my_element.screen_query
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.when_present
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices (RuntimeError)'
    end
    begin
      @my_element.when_not_present
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices (RuntimeError)'
    end
    begin
      @my_element.is_present?
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.prod
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.input('test_string')
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.check
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.uncheck
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.checked?
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.text
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.look_for
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
  end
end
