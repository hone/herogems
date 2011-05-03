require 'heroku/command/base'

class Herogems < Heroku::Command::Base
  def index
    if HerogemsLoader.list.empty?
      puts "No herogems installed."
    else
      HerogemsLoader.list.each {|gem| puts gem }
    end
  end

  def enable
    gem_name = args.shift
    if gem_name && HerogemsLoader.load_gem(gem_name)
      HerogemsLoader.write_config
    elsif gem_name
      puts "Missing gem '#{gem_name}'. To install missing gem, run: gem install #{gem_name}"
    else
      puts "Requires a gem name: heroku herogems:enable gem"
    end
  end
end
