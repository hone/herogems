require File.join(File.dirname(__FILE__), '../../spec_helper')

describe "Herogems" do
  describe "#enable" do
    context "gem is already installed" do
      before do
        gem_install('herobro')
      end

      it 'should enable the gem' do
        run("herogems:enable herobro")

        run("herogems").should include("herobro")
        run("plugins").should include("bro (or go home")
      end
    end

    context "gem is not installed" do
      it "should throw an error" do
        run("herogems:enable herobro").should include("Missing gem 'herobro'. To install missing gem, run: gem install herobro")
      end

      it "should not enable any herogems" do
        run("herogems:enable herobro")

        run("herogems").should include("No herogems installed.")
      end
    end

    context "no argument is passed in" do
      it "should throw an error" do
        run("herogems:enable").should include("Requires a gem name: heroku herogems:enable gem")
      end
    end
  end
end
