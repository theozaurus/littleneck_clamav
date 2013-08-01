shared_examples_for "a scanner" do

 describe "instance method" do

    describe "engine" do

      it "should call Cocaine with correct parameters" do
        mock_cocaine :cmd => subject.command, :opts => "--version", :params => { :swallow_stderr => true }
        subject.engine
      end

      it "should interpret the return value correctly" do
        mock_cocaine :output => "ClamAV 0.97.5/15306/Tue Aug 28 20:18:12 2012\n"
        subject.engine.should == "0.97.5"
      end

    end

    describe "database_version" do

      it "should call Cocaine with correct parameters" do
        mock_cocaine :cmd => subject.command, :opts => "--version", :params => { :swallow_stderr => true }
        subject.database_version
      end

      it "should interpret the return value correctly" do
        mock_cocaine :output => "ClamAV 0.97.5/15306/Tue Aug 28 20:18:12 2012\n"
        subject.database_version.should == 15306
      end

    end

    describe "database_version" do

      it "should call Cocaine with correct parameters" do
        mock_cocaine :cmd => subject.command, :opts => "--version", :params => { :swallow_stderr => true }
        subject.database_date
      end

      it "should interpret the return value correctly" do
        mock_cocaine :output => "ClamAV 0.97.5/15306/Tue Aug 28 20:18:12 2012\n"
        subject.database_date.should == Time.parse("Tue Aug 28 20:18:12 2012")
      end

    end

    describe "available?" do

      it "should return true when Cocaine returns okay" do
        mock_cocaine :output => "ClamAV 0.97.5/15306/Tue Aug 28 20:18:12 2012\n"

        subject.available?.should == true
      end

      it "should return false when command errors" do
        mock_cocaine :raise => Cocaine::ExitStatusError.new( "oh noes" )

        subject.available?.should == false
      end

      it "should return false when command is not found" do
        mock_cocaine :raise => Cocaine::CommandNotFoundError

        subject.available?.should == false
      end

    end

    describe "scan" do

      it "should create a Result" do
        file = __FILE__

        subject.stub(:available?).and_return(true)

        mock_cocaine :output => "#{file}: OK\n"

        LittleneckClamAV::Result.should_receive(:new).with(:path => file, :clean => true, :description => "OK")

        subject.scan file
      end

      it "should raise an error if the path does not exist" do
        lambda { subject.scan "foo" }.should raise_error( LittleneckClamAV::Error )
      end

      it "should raise an error if it is not available" do
        file = __FILE__

        subject.stub(:available?).and_return(false)

        lambda { subject.scan "foo" }.should raise_error( LittleneckClamAV::Error )
      end

    end

  end

end
