require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

require 'jsonlint/rake_task'
JsonLint::RakeTask.new do |t|
  t.paths = %w[
    palettes/**/*.json
  ]
end

require 'reek/rake/task'

Reek::Rake::Task.new do |t|
  t.fail_on_error = false
end

task default: :test
