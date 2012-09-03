require "spec_helper"

describe LittleneckClamAV::Result do

  describe "instance method" do

    describe "infected?" do

      it "should return true when infected" do
        result = result_factory :clean => false
        result.infected?.should be_true
      end

      it "should return false when clean" do
        result = result_factory :clean => true
        result.infected?.should be_false
      end

    end

    describe "clean?" do

      it "should return true when clean" do
        result = result_factory :clean => true
        result.clean?.should be_true
      end

      it "should return false when infected" do
        result = result_factory :clean => false
        result.clean?.should be_false
      end

    end

    describe "description" do

      it "should return the description passed in" do
        result = result_factory :description => "Hello"
        result.description.should == "Hello"
      end

    end

    describe "path" do

      it "should return the path passed in" do
        result = result_factory :path => "foo/bar"
        result.path.should == "foo/bar"
      end

    end

  end

end
