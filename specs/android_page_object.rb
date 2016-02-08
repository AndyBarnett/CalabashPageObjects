require 'calabash-page-objects'
# Page object for tests.
class AndroidPageObjectClass
  # rubocop:disable CyclomaticComplexity
  # rubocop:disable PerceivedComplexity
  # rubocop:disable AbcSize
  def initialize
    @my_element = AElement.new("* text:'ggg'")
  end

  def try_all_methods
    begin
      @my_element.screen_query
      @my_element.touch('asdf')

    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.when_visible
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.when_not_visible
    rescue RuntimeError => e
      raise unless e.message == 'No connected devices'
    end
    begin
      @my_element.present?
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
