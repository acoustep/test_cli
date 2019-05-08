require "admiral"

class TestCli < Admiral::Command
  define_version "1.0.1"
  def run
    puts "Hello World"
  end
end

TestCli.run
