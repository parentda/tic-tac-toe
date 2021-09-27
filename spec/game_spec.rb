require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Game do
  describe '#play' do
    subject(:game) { described_class.new(2, 3) }
    context 'when total moves are equal to max moves' do
      it 'exits game loop' do
        allow(game).to receive(:game_start_message)
        allow(game).to receive(:game_tie_message)
        game.instance_variable_set(:@total_moves, 9)
        expect(game).to_not receive(:user_turn)
        game.play
      end
    end

    context 'when @game_win is true' do
      it 'exits game loop' do
        allow(game).to receive(:game_start_message)
        allow(game).to receive(:game_tie_message)
        game.instance_variable_set(:@game_win, true)
        expect(game).to_not receive(:user_turn)
        game.play
      end
    end
  end
end
