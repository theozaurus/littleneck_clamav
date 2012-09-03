describe LittleneckClamAV::Clamd do

  it_behaves_like "a scanner"

  describe "instance method" do

    describe "command" do

      it "should return clamdscan" do
        subject.command.should == "clamdscan"
      end

    end

  end

end
