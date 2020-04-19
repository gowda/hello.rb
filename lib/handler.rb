# frozen_string_literal: true

class Handler
  attr_reader :env

  def initialize(env)
    @env = env
  end

  def erb(filename, local = {})
    b = binding

    message = local[:message] # rubocop:disable Lint/UselessAssignment

    content = File.read(path_for(filename))
    ERB.new(content).result(b)
  end

  def path_for(filename)
    File.expand_path("../app/views/#{filename}.erb", __dir__)
  end

  def response(status, headers, body = '')
    status = '200' if blank?(status)
    body = yield if block_given?
    [status, headers, [body]]
  end

  def blank?(str)
    str.nil? || str.strip.empty?
  end
end
