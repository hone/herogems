module RSpec
  module Helpers
    def plugin_gem_path(name, version = '1.0.0')
      File.expand_path("../../resources/#{name}/#{name}-#{version}.gem", __FILE__)
    end
  end
end
