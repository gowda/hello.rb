# frozen_string_literal: true

require 'rack/test'

module RackHelper
  include Rack::Test::Methods

  def app
    described_class.new
  end
end

RSpec.configure do |config|
  config.include RackHelper
end
