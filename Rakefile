# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

desc 'environment setup'
task :environment do
  ENV['RACK_ENV'] = ENV.fetch('RACK_ENV') { 'development' }
end

desc 'start server'
task server: :environment do
  require 'rack'
  require_relative 'app'

  Rack::Server.start(
    app: Rack::ShowExceptions.new(Rack::Lint.new(App.new)),
    Port: 9292
  )
rescue LoadError => e
  abort "Could not load rack: #{e.inspect}"
end

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

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:cop)
rescue LoadError => e
  abort "Coult not load rubocop tasks: #{e.inspect}"
end

task default: %i[cop spec]
