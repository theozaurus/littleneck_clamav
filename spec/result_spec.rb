require "spec_helper"

RSpec.describe LittleneckClamAV::Result do

  describe "instance method" do

    describe "infected?" do

      it "should return true when infected" do
        result = result_factory :clean => false
        expect(result.infected?).to be(true)
      end

      it "should return false when clean" do
        result = result_factory :clean => true
        expect(result.infected?).to be(false)
      end

    end

    describe "clean?" do

      it "should return true when clean" do
        result = result_factory :clean => true
        expect(result.clean?).to be(true)
      end

      it "should return false when infected" do
        result = result_factory :clean => false
        expect(result.clean?).to be(false)
      end

    end

    describe "description" do

      it "should return the description passed in" do
        result = result_factory :description => "Hello"
        expect(result.description).to  eql("Hello")
      end

    end

    describe "path" do

      it "should return the path passed in" do
        result = result_factory :path => "foo/bar"
        expect(result.path).to  eql("foo/bar")
      end

    end

  end

end
