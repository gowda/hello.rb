# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

desc 'environment setup'
task :environment do
  ENV['RACK_ENV'] = ENV.fetch('RACK_ENV', 'development')
end

Rake::FileList['tasks/**/*.rake'].each do |file|
  load file
end

task default: %i[cop spec]
