require "spec_helper"

RSpec.describe LittleneckClamAV do

  describe "instance method" do

    let(:scanner) { double("scanner") }

    describe "engine" do

      it "should call `engine` on the scanner" do
        expect(scanner).to receive(:engine)
        allow(subject).to receive(:scanner).and_return(scanner)

        subject.engine
      end

    end

    describe "database_version" do

      it "should call `database_version` on the scanner" do
        expect(scanner).to receive(:database_version)
        allow(subject).to receive(:scanner).and_return(scanner)

        subject.database_version
      end

    end

    describe "database_date" do

      it "should call `database_date` on the scanner" do
        expect(scanner).to receive(:database_date)
        allow(subject).to receive(:scanner).and_return(scanner)

        subject.database_date
      end

    end

    describe "available?" do

      it "should return true if a scanner is available" do
        allow(subject).to receive(:scanner).and_return(Object.new)

        expect(subject.available?).to be(true)
      end

      it "should return false if a scanner is not available" do
        allow(subject).to receive(:scanner).and_return(nil)

        expect(subject.available?).to be(false)
      end

    end

    describe "scan" do

      it "should call `scan` on the scanner" do
        expect(scanner).to receive(:scan)
        allow(subject).to receive(:scanner).and_return(scanner)

        subject.scan
      end

    end

    describe "scanner" do

      it "should return Clamd if available" do
        allow_any_instance_of(LittleneckClamAV::Clamd).to(
          receive(:available?).and_return(true))

        expect(subject.scanner).to be_a(LittleneckClamAV::Clamd)
      end

      it "should return Clam if Clamd is not available" do
        allow_any_instance_of(LittleneckClamAV::Clamd).to(
          receive(:available?).and_return(false))
        allow_any_instance_of(LittleneckClamAV::Clam).to(
          receive(:available?).and_return(true))

        expect(subject.scanner).to be_a(LittleneckClamAV::Clam)
      end

      it "should raise an error if neither are available" do
        allow_any_instance_of(LittleneckClamAV::Clamd).to(
          receive(:available?).and_return(false))
        allow_any_instance_of(LittleneckClamAV::Clam).to(
          receive(:available?).and_return(false))

        expect{subject.scanner}.to raise_error(LittleneckClamAV::Error)
      end

    end

  end

end
