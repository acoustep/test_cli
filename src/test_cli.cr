require "admiral"

class HelloWorld < Admiral::Command
  def run
    puts "Hello World"
  end
end

HelloWorld.run
