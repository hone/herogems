require File.join(File.dirname(__FILE__), 'spec_helper')

describe "test framework", :pending => true do
  it "should not blow up" do
    run("help db", :expect_error => true)
    @err.should be_empty
  end

  it "should install the gem" do
    # need to ignore for now, need to find a non broken rubygems
    `gem install #{plugin_gem_path('herobro')} --no-ri --no-rdoc --ignore-dependencies`
    `gem list`.should include("herobro")
  end
end
