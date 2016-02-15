require_relative '../lib/CalabashPageObjects'
# Page object for tests.
class IosPageObjectClass
  # rubocop:disable CyclomaticComplexity
  # rubocop:disable PerceivedComplexity
  # rubocop:disable AbcSize
  def initialize
    @my_element = IElement.new("* text:'ggg'")
  end

  def try_all_methods
    begin
      @my_element.screen_query
    rescue Errno::ECONNREFUSED => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265)'
    end
    begin
      @my_element.when_visible
    rescue RuntimeError => e
      raise unless e.message == 'Connection refused - connect(2) (http://localhost:37265) (Errno::ECONNREFUSED)'
    end
    begin
      @my_element.when_not_visible
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
