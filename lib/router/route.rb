# frozen_string_literal: true

class Route
  attr_accessor :path, :options

  def initialize(args)
    @path = args[0]
    @options = args[1]
  end

  def klass_name
    options[:klass].split('_').map(&:capitalize).join
  end

  def klass_def_filename
    options[:klass]
  end

  def method_name
    options[:method]
  end

  def klass
    Module.const_get(klass_name)
  rescue NameError => _e
    begin
      require klass_def_filename
      Module.const_get(klass_name)
    rescue LoadError => _e
      raise NameError, "handler not defined for #{path}"
    end
  end

  def execute(env)
    klass.new(env).send(method_name.to_sym)
  end

  def eql?(other)
    path == other.path && options.eql?(other.options)
  end
end
