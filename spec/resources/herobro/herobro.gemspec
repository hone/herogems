Gem::Specification.new do |gem|
  gem.name    = "herobro"
  gem.version = '1.0.0'

  gem.author      = "Herobros"
  gem.email       = "bros@heroku.com"
  gem.homepage    = "http://bros.heroku.com/"
  gem.summary     = "Bros on every heroku"
  gem.description = "Bros on every heroku"

  gem.files = Dir["**/*"].select { |d| d =~ %r{^(README|bin/|data/|ext/|lib/|spec/|test/)} }
  gem.add_dependency "heroku"
end
