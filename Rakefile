# vim:filetype=ruby
require 'rake'
require 'rake/testtask'
require 'yaml'
require 'rcov/rcovtask'
require 'dm-core'

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

task :loadconfig do
  DBConfig = YAML::load(File.open('db/config.yml'))['development']
end

task :migrate => :loadconfig do
  migrate(DBConfig)
end

def migrate(config)
  DataMapper::Logger.new($stdout, :debug)
  case config['adapter']
  when 'sqlite3'
    DataMapper.setup(:default, "sqlite3:#{config['database']}")
  end
  DataMapper.auto_migrate!
end

