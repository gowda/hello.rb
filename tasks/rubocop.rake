# frozen_string_literal: true

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:cop)
rescue LoadError => e
  abort "Could not load rubocop tasks: #{e.inspect}" if ENV['RACK_ENV'] != 'production'
end
