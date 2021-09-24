require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    context 'when a new Player instance is created' do
      before do
        allow(Player).to receive(:parse_name).and_return('Test')
        allow(Player).to receive(:parse_marker).and_return('X')
      end
      it 'increases @@player_number by 1' do
        expect { Player.new(3) }.to change { Player.player_number }.by(1)
      end
    end
  end
end
