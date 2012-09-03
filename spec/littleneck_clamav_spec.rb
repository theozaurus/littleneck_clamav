require "spec_helper"

describe LittleneckClamAV do

  describe "instance method" do

    describe "engine" do

      it "should call `engine` on the scanner" do
        scanner = mock("scanner")
        scanner.should_receive :engine
        subject.stub( :scanner => scanner )

        subject.engine
      end

    end

    describe "database_version" do

      it "should call `database_version` on the scanner" do
        scanner = mock("scanner")
        scanner.should_receive :database_version
        subject.stub( :scanner => scanner )

        subject.database_version
      end

    end

    describe "database_date" do

      it "should call `database_date` on the scanner" do
        scanner = mock("scanner")
        scanner.should_receive :database_date
        subject.stub( :scanner => scanner )

        subject.database_date
      end

    end

    describe "available?" do

      it "should return true if a scanner is available" do
        subject.stub( :scanner => Object.new )

        subject.available?.should == true
      end

      it "should return false if a scanner is not available" do
        subject.stub( :scanner => nil )

        subject.available?.should == false
      end

    end

    describe "scan" do

      it "should call `scan` on the scanner" do
        scanner = mock("scanner")
        scanner.should_receive :scan
        subject.stub( :scanner => scanner )

        subject.scan
      end

    end

    describe "scanner" do

      it "should return Clamd if available" do
        LittleneckClamAV::Clamd.any_instance.stub(:available? => true)

        subject.scanner.should be_a LittleneckClamAV::Clamd
      end

      it "should return Clam if Clamd is not available" do
        LittleneckClamAV::Clamd.any_instance.stub(:available? => false)
        LittleneckClamAV::Clam.any_instance.stub(:available? => true)

        subject.scanner.should be_a LittleneckClamAV::Clam
      end

      it "should raise an error if neither are available" do
        LittleneckClamAV::Clamd.any_instance.stub(:available? => false)
        LittleneckClamAV::Clam.any_instance.stub(:available? => false)

        lambda { subject.scanner }.should raise_error( LittleneckClamAV::Error )
      end

    end

  end

end
