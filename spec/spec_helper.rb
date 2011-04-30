# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.expand_path('../support', __FILE__)}/*.rb"].each {|f| require f}

$show_err = true

RSpec.configure do |config|
  config.include RSpec::Helpers
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with ""

  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
  config.alias_example_to :fit, :focused => true

  original_path     = ENV['PATH']
  original_gem_home = ENV['GEM_HOME']
  original_gem_path = ENV['GEM_PATH']

  # must do before we kill bundler
  HEROKU_BIN = "#{`bundle show heroku`.chomp}/bin/heroku"

  config.before do
    reset!
  end

  config.after do
    ENV['PATH']     = original_path
    ENV['GEM_HOME'] = original_gem_home
    ENV['GEM_PATH'] = original_gem_path
  end
end
