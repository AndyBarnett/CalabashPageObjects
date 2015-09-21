require 'bundler/gem_tasks'
require 'geminabox'

task :build do
  system 'gem build CalabashPageObjects.gemspec'
end

task upload_to_internal_server: :build do
  system "gem inabox pkg/CalabashPageObjects-#{CalabashPageObjects::VERSION}.gem -g http://gems.ict.je-labs.com:8808"
end
