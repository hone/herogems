require 'set'

module HerogemsLoader

  include Heroku::Helpers
  extend self

  def exists?
    File.exists?("#{home_directory}/.heroku/heroku-gems")
  end

  def config_file
    "#{home_directory}/.heroku/heroku-gems"
  end

  def config
    YAML.load(File.open(config_file))
  end

  def list
    @@list ||= Set.new
  end

  def load_gems
    error_occurred = false
    return unless exists?
    config.each do |gem|
      error_occurred = true unless load_gem(gem)
    end
    puts fail_instructions if error_occurred
  end

  def load_gem(gem)
    list.add(gem)
    gem_as_path = gem.gsub('-', '/')
    if gem != gem_as_path
      begin
        require gem_as_path
      rescue LoadError
        require gem
      rescue LoadError
        puts "Unable to require '#{gem}' (or '#{gem_as_path}'), skipping."
        list.delete(gem)
        return false
      end
    else
      begin
        require gem
      rescue LoadError
        puts "Unable to load '#{gem}', skipping."
        list.delete(gem)
        return false
      end
    end

    return true
  end

  def write_config
    File.open(config_file, 'w') {|file| file.write(self.list.to_yaml) }
  end

  def fail_instructions
    [ "To stop trying to load a gem, run: heroku plugins:disable gemname",
      "To install a missing gem, run: gem install gemname" ].join("\n")
  end
end
