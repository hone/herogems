Gem::Specification.new do |gem|
  gem.name    = "heroku-meow"
  gem.version = '1.0.0'

  gem.author      = "Gimlicat"
  gem.email       = "gimli@heroku.com"
  gem.homepage    = "http://gimli.heroku.com/"
  gem.summary     = "Meow, meow meow, meow meow meow. Meow!"
  gem.description = "Meow."

  gem.files = Dir["**/*"].select { |d| d =~ %r{^(README|bin/|data/|ext/|lib/|spec/|test/)} }
  gem.add_dependency "heroku", ">= 1.20.0"
end
