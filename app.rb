# frozen_string_literal: true

$LOAD_PATH << File.expand_path(__dir__)
['lib', 'app/handlers'].each do |p|
  $LOAD_PATH << File.expand_path(p, __dir__)
end

require 'router'

class App
  def initialize
    @router = Router.new
    @router.configure do
      get '/', to: 'hello#index'
      get '/advice', to: 'advice#index'
      get %r{.*}, to: 'error_handler#http404' # rubocop:disable Style/RegexpLiteral
    end
  end

  def call(env)
    @router.route_for(env).execute(env)
  end
end
