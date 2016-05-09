require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.name = 'test' # This is the default test directory
  t.libs << 'test' # Load the test directory
  t.test_files = Dir['test/*test*.rb']
  t.verbose = true
end
