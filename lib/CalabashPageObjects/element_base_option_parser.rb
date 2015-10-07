# A class that handles merging of default options.
module ElementBaseOptionParser
  # Merges provided options with defaults.
  def options_parser(input_options, defaults = {})
    if input_options.is_a?(Integer) || input_options.is_a?(Float)
      timeout_only_output_options = {}
      timeout_only_output_options[:timeout] = input_options
      timeout_only_output_options
    else
      defaults.merge(input_options)
    end
  end

  private :options_parser
end
