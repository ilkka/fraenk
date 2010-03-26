# vim:filetype=ruby
require 'rcov/rcovtask'

desc 'Create coverage report'
Rcov::RcovTask.new do |t|
  t.test_files = FileList['test/*/test_*.rb']
  t.rcov_opts << "-x='*/gems/*'"
  t.verbose = true
end

