# vim:filetype=ruby
require 'rake'
require 'rake/testtask'
require 'yaml'
require 'rcov/rcovtask'

task :default => :test
task :test => [:unittest, :rcov]

desc 'Run unit tests'
Rake::TestTask.new do |t|
  t.name = :unittest
  t.test_files = FileList['test/*/test_*.rb']
  t.verbose = true
end

desc 'Create coverage report'
Rcov::RcovTask.new do |t|
  t.test_files = FileList['test/*/test_*.rb']
  t.rcov_opts << "-x='*/gems/*'"
  t.verbose = true
end

