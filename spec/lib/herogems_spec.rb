require File.join(File.dirname(__FILE__), '../spec_helper')

describe "Herogems" do
  describe "test framework" do
    xit "should not blow up" do
      run("help db", :expect_error => true)
      @err.should be_empty
    end

    xit "should install the gem" do
      # need to ignore for now, need to find a non broken rubygems
      `gem install #{plugin_gem_path('herobro')} --no-ri --no-rdoc --ignore-dependencies`
      `gem list`.should include("herobro")
    end
  end
end
