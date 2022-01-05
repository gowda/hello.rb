# frozen_string_literal: true

desc 'Start web server'
task server: :environment do
  require 'rack'
  require_relative '../app'

  Rack::Server.start(
    app: Rack::ShowExceptions.new(Rack::Lint.new(App.new)),
    Port: ENV.fetch('PORT', 9292)
  )
rescue LoadError => e
  abort "Could not load rack: #{e.inspect}"
end
