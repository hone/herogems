require 'heroku/command/base'

class Herogems < Heroku::Command::Base
  def index
    if HerogemsLoader.list.empty?
      puts "No herogems installed."
    else
      HerogemsLoader.list.each {|gem| puts gem }
    end
  end
end
