require 'zeus/rails'

# see https://github.com/burke/zeus/wiki/Contributed-Plans
class Popeye < Zeus::Rails
  def spinach_environment
    require 'spinach'
  end

  def spinach
    spinach_main = Spinach::Cli.new(ARGV.dup)
    #spinach_main.init_reporter
    exit spinach_main.run
  end
end

Zeus.plan = Popeye.new
