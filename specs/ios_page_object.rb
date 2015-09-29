require 'CalabashPageObjects'
class IosPageObjectClass < CalabashPageObjectBase
  def initialize(world)
    @my_element = IElement.new("* text:'ggg'")
    super(world)
  end

  def try_all_methods
    begin
      @my_element.screen_query
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
    begin
      @my_element.when_present
    rescue RuntimeError => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265) (Errno::ECONNREFUSED)'
    end
    begin
      @my_element.when_not_present
    rescue RuntimeError => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265) (Errno::ECONNREFUSED)'
    end
    begin
      @my_element.present?
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
    begin
      @my_element.prod
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
    begin
      @my_element.input('test_string')
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
    begin
      @my_element.check
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
    begin
      @my_element.uncheck
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
    begin
      @my_element.checked?
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
    begin
      @my_element.text
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
    begin
      @my_element.look_for
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
  end
end

require 'calabash-cucumber'
require 'calabash-cucumber/ibase'
class OldIosPageObject < CalabashIosBase
  element(:test, "string")

  def test_method
    methods = self.methods.select{|x| x =~ /when/}
    fail unless methods.size > 0
  end
end