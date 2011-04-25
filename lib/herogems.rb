module Herogems

  include Heroku::PluginInterface
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

  def load_gems
    error_occurred = false
    config.each do |gem|
      gem_as_path = gem.gsub('-', '/')
      if gem != gem_as_path
        begin
          require gem_as_path
        rescue LoadError
          require gem
        rescue LoadError
          puts "Unable to require '#{gem}' (or '#{gem_as_path}'), skipping."
          error_occurred = true
        end
      else
        begin
          require gem
        rescue LoadError
          puts "Unable to load '#{gem}', skipping."
          error_occurred = true
        end
      end
    end
    puts fail_instructions if error_occurred
  end

  def fail_instructions
    [ "To stop trying to load a gem, run: heroku plugins:disable gemname",
      "To install a missing gem, run: gem install gemname" ].join("\n")
  end
end
