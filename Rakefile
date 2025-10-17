require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"

RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new("spec:doc") do |t|
  t.rspec_opts = "--format documentation"
end

task default: [:standard, :spec]
task lint: :standard
task "lint:fix": :"standard:fix"
task test: :spec
task "test:doc": :"spec:doc"
