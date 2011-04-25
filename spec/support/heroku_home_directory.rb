require 'heroku'
require 'heroku/command'
require 'heroku/helpers'

Heroku::Helpers.module_eval do
  def home_directory
    File.join(File.dirname(__FILE__), "../../tmp")
  end
end
