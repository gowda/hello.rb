# frozen_string_literal: true

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:cop)
rescue LoadError => e
  if ENV['RACK_ENV'] != 'production'
    abort "Could not load rubocop tasks: #{e.inspect}"
  end
end
