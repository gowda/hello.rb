# frozen_string_literal: true

class Handler
  attr_reader :env, :message

  def initialize(env)
    @env = env
  end

  def layout_content
    File.read(path_for(:layout))
  rescue Errno::ENOENT => _e
    '<%= yield %>'
  end

  def layout
    ERB.new(layout_content)
  end

  def template_content(name)
    File.read(path_for(name))
  end

  def template(name)
    ERB.new(template_content(name))
  end

  def erb(filename, locals = {})
    layout.def_method(self.class, :render_layout)

    @message = locals[:message]
    template(filename).def_method(self.class, :render_template)

    render_layout { render_template }
  end

  def request
    @request ||= Rack::Request.new(env)
  end

  def response(status, headers, body = '')
    status = '200' if blank?(status)
    body = yield if block_given?
    [status, headers, [body]]
  end

  def blank?(str)
    str.nil? || str.strip.empty?
  end

  def path_for(filename)
    File.expand_path("../app/views/#{filename}.erb", __dir__)
  end
end
