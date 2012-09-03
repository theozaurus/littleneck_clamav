require "spec_helper"

describe LittleneckClamAV::Clam do

  it_behaves_like "a scanner"

  describe "instance method" do

    describe "command" do

      it "should return clamdscan" do
        subject.command.should == "clamscan"
      end

    end

  end

end
