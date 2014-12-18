shared_examples_for 'a scanner' do

  describe 'instance method' do

    describe 'engine' do

      it 'should call Cocaine with correct parameters' do
        mock_cocaine cmd: subject.command, opts: '--version', params: { swallow_stderr: true }
        subject.engine
      end

      it 'should interpret the return value correctly' do
        mock_cocaine output: "ClamAV 0.97.5/15306/Tue Aug 28 20:18:12 2012\n"
        expect(subject.engine).to eql('0.97.5')
      end

    end

    describe 'database_version' do

      it 'should call Cocaine with correct parameters' do
        mock_cocaine cmd: subject.command, opts: '--version', params: { swallow_stderr: true }
        subject.database_version
      end

      it 'should interpret the return value correctly' do
        mock_cocaine output: "ClamAV 0.97.5/15306/Tue Aug 28 20:18:12 2012\n"
        expect(subject.database_version).to eql(15_306)
      end

    end

    describe 'database_version' do

      it 'should call Cocaine with correct parameters' do
        mock_cocaine cmd: subject.command, opts: '--version', params: { swallow_stderr: true }
        subject.database_date
      end

      it 'should interpret the return value correctly' do
        mock_cocaine output: "ClamAV 0.97.5/15306/Tue Aug 28 20:18:12 2012\n"
        expect(subject.database_date).to eql(Time.parse('Tue Aug 28 20:18:12 2012'))
      end

    end

    describe 'available?' do

      it 'should return true when Cocaine returns okay' do
        mock_cocaine output: "ClamAV 0.97.5/15306/Tue Aug 28 20:18:12 2012\n"

        expect(subject.available?).to be(true)
      end

      it 'should return false when command errors' do
        mock_cocaine raise: Cocaine::ExitStatusError.new('oh noes')

        expect(subject.available?).to be(false)
      end

      it 'should return false when command is not found' do
        mock_cocaine raise: Cocaine::CommandNotFoundError

        expect(subject.available?).to be(false)
      end

    end

    describe 'scan' do

      it 'should create a Result' do
        file = __FILE__

        allow(subject).to receive(:available?).and_return(true)

        mock_cocaine output: "#{file}: OK\n"

        expect(LittleneckClamAV::Result).to receive(:new).with(path: file, clean: true, description: 'OK')

        subject.scan file
      end

      it 'should raise an error if the path does not exist' do
        expect { subject.scan 'foo' }.to raise_error(LittleneckClamAV::Error)
      end

      it 'should raise an error if it is not available' do
        file = __FILE__

        allow(subject).to receive(:available?).and_return(false)

        expect { subject.scan 'foo' }.to raise_error(LittleneckClamAV::Error)
      end

    end

  end

end
