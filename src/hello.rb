require 'defaults'

class Hello
  attr_reader :greeting
  alias :greet :greeting
  
  def initialize(name = NAME)
    name = NAME if name.empty?
    @greeting = "#{PREFIX} #{name}!"
  end
end

if __FILE__ == $0
  if ARGV.empty?
    puts Hello.new.greet
  else
    ARGV.each do |name|
      puts Hello.new(name).greet
    end
  end
end
