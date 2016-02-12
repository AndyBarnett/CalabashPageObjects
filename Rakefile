require 'bundler/gem_tasks'

task :build do
	system 'gem build CalabashPageObjects.gemspec'
end

task :push, [:auth] do |t, args|
	task(:build).execute
	  system "curl --data-binary @calabash-page-objects-#{CalabashPageObjects::VERSION}.gem \
       -H 'Authorization:#{args[:auth]}’ \
       https://rubygems.org/api/v1/gems"
end
