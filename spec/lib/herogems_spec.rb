require File.join(File.dirname(__FILE__), '../spec_helper')
require 'yaml'

describe "Herogems" do
  describe ".load_gems" do
    context "no enabled / installed gems" do
      it "should load the gem" do
        run("plugins").should == "herogems"
      end

      it "should not list any gems" do
        run("herogems").should == "No herogems installed."
      end
    end

    context "no enabled plugins but plugins installed" do
      before do
        system("gem install #{plugin_gem_path('herobro')} --ignore-dependencies --no-ri --no-rdoc > /dev/null")
      end

      it "should not load any installed plugins" do
        run("plugins").should == "herogems"
      end

      it "should not list any gems" do
        run("herogems").should == "No herogems installed."
      end
    end

    context "loads enabled gems" do
      before do
        system("gem install #{plugin_gem_path('herobro')} --ignore-dependencies --no-ri --no-rdoc > /dev/null")
        File.open(HerogemsLoader::config_file, 'w') {|file| file.write(['herobro'].to_yaml) }
      end

      it "should load the enabled gem" do
        run("plugins").should include("bro (or go home)")
      end

      it "should list the enabled gem" do
        run("herogems").should include("herobro")
      end
    end

    context "problems loading a gem" do
      before do
        File.open(HerogemsLoader::config_file, 'w') {|file| file.write(['herobro'].to_yaml) }
      end

      it "should not load any installed plugins" do
        run("plugins").should include("herogems")
      end

      it "should not list the enabled gem" do
        run("herogems").should include("No herogems installed.")
      end
    end
  end
end
