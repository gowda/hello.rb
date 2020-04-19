# frozen_string_literal: true

require 'router/route'

class Router
  attr_reader :routes

  def initialize
    @routes = Hash.new { |h, k| h[k] = [] }
  end

  def configure(&block)
    instance_eval(&block)
  end

  def get(path, options = {})
    @routes[:get] << [path, parse_to(options[:to])]
  end

  def route_for(env)
    path = env['PATH_INFO']
    method = env['REQUEST_METHOD'].downcase.to_sym
    route_array = routes[method].detect do |route|
      match?(route, path)
    end

    return Route.new(route_array) if route_array

    nil
  end

  private

  def parse_to(to)
    klass, method = to.split('#')
    { klass: klass, method: method }
  end

  def match?(route, path)
    case route[0]
    when String
      path == route[0]
    when Regexp
      path =~ route[0]
    end
  end
end
