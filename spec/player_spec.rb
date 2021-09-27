require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    subject(:initialize_player) { described_class }
    context 'when a new Player instance is created' do
      before do
        allow(initialize_player).to receive(:parse_name).and_return('Test')
        allow(initialize_player).to receive(:parse_marker).and_return('X')
      end
      it 'increases @@player_number by 1' do
        expect { initialize_player.new(3) }.to change {
          initialize_player.player_number
        }.by(1)
      end
    end
  end

  describe '.parse_marker' do
    subject(:input_marker) { described_class }
    let(:error_message) do
      'Please re-enter your marker choice and ensure that it is a single character that is not already in use: '
    end

    context 'when user inputs a valid marker' do
      before do
        allow(input_marker).to receive(:puts)
        allow(input_marker).to receive(:print)
        allow(input_marker).to receive(:gets).and_return('X')
      end

      it 'stops loop and does not display error message' do
        expect(input_marker).not_to receive(:print).with(error_message)
        input_marker.parse_marker
      end
    end

    context 'when user inputs an invalid marker once, then a valid marker' do
      before do
        allow(input_marker).to receive(:puts)
        allow(input_marker).to receive(:print)
        allow(input_marker).to receive(:gets).and_return('X', 'Y')
      end

      it 'stops loop and does not display error message' do
        expect(input_marker).to receive(:print).with(error_message).once
        input_marker.parse_marker
      end
    end

    context 'when user inputs an invalid marker twice, then a valid marker' do
      before do
        allow(input_marker).to receive(:puts)
        allow(input_marker).to receive(:print)
        allow(input_marker).to receive(:gets).and_return('X', 'Y', 'Z')
      end

      it 'stops loop and does not display error message' do
        expect(input_marker).to receive(:print).with(error_message).twice
        input_marker.parse_marker
      end
    end
  end

  describe '.update_taken_markers' do
    context 'when '
    xit 'adds valid marker to @@taken_markers' do
      expect { input_marker.parse_marker }.to change {
        input_marker.taken_markers.length
      }.by(1)
    end

    xit 'returns valid marker' do
      valid_marker = input_marker.parse_marker
      expect(valid_marker).to eq(valid_input)
    end
  end
end
