require 'bundler/gem_tasks'
require 'geminabox'

task :build do
  system 'gem build CalabashPageObjects.gemspec'
end

task upload_to_internal_server: :build do
  system "gem inabox pkg/CalabashPageObjects-#{calabash-page-objects::VERSION}.gem -g http://gems.ict.je-labs.com:8808"
end

task push: :build do
  system "gem push pkg/calabash-page-objects-#{CalabashPageObjects::VERSION}.gem"
end