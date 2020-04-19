# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |task|
    ENV['RACK_ENV'] = 'test'
    ruby_opts = ["-I#{File.expand_path(__dir__)}"]
    ['lib', 'app/handlers'].each do |p|
      ruby_opts << "-I#{File.expand_path(p, __dir__)}"
    end

    task.ruby_opts = ruby_opts.join(' ')
  end
rescue LoadError => e
  abort "Could not load rspec tasks: #{e.inspect}"
end

task default: :spec
