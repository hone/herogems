require File.join(File.dirname(__FILE__), '../spec_helper')
require 'yaml'

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

  describe ".load_gems" do
    context "no enabled / installed gems" do
      it "should load the gem" do
        run("plugins").should == "herogems"
      end
    end

    context "no enabled plugins but plugins installed" do
      before do
        system("gem install #{plugin_gem_path('herobro')} --ignore-dependencies --no-ri --no-rdoc > /dev/null")
      end

      it "should not load any installed plugins" do
        run("plugins").should == "herogems"
      end
    end

    context "loads enabled gems" do
      before do
        system("gem install #{plugin_gem_path('herobro')} --ignore-dependencies --no-ri --no-rdoc > /dev/null")
        File.open(Herogems::config_file, 'w') {|file| file.write(['herobro'].to_yaml) }
      end

      it "should load the enabled gem" do
        run("plugins").should include("bro (or go home)")
      end
    end
  end
end
