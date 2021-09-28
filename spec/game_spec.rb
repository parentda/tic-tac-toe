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

  describe '#user_move' do
    subject(:game) { described_class.new(2, 3) }
    let(:player) { instance_double(Player, marker: 'X') }
    let(:board) { instance_double(Board) }
    let(:valid_input) { '6' }
    let(:invalid_input) { '10' }
    before { allow(board).to receive(:validate_move).and_return([1, 2]) }

    context 'when user input is valid' do
      before { allow(game).to receive(:gets).and_return(valid_input) }

      it 'stops loop and does not display error message' do
        expect(game).not_to receive(:invalid_selection_message)
        game.user_move(player, board)
      end

      it 'returns valid coordinates' do
        coords = game.user_move(player, board)
        expect(coords).to eq([1, 2])
      end
    end

    context 'when user inputs an incorrect value once, then a valid input' do
      before do
        allow(game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'completes loop and displays error message once' do
        expect(game).to receive(:invalid_selection_message).once
        game.user_move(player, board)
      end
    end

    context 'when user inputs two incorrect values, then a valid input' do
      before do
        allow(game).to receive(:gets).and_return(
          invalid_input,
          invalid_input,
          valid_input
        )
      end

      it 'scompletes loop and displays error message twice' do
        expect(game).to receive(:invalid_selection_message).twice
        game.user_move(player, board)
      end
    end
  end

  describe '#user_turn' do
    subject(:game) { described_class.new(2, 3) }
    let(:player) { instance_double(Player, marker: 'X') }
    before do
      game.instance_variable_set(:@players, [player, player])
      allow(game).to receive(:user_move).and_return([1, 2])
      allow(game).to receive(:next_turn_message)
      allow(game).to receive(:puts)
      allow(game).to receive(:game_win_message)
      allow(player).to receive(:update_my_positions)
    end

    context 'when a turn is made and the game continues' do
      it 'increases total move count by 1' do
        expect { game.user_turn }.to change { game.total_moves }.by(1)
      end

      it 'changes current player index' do
        expect { game.user_turn }.to change {
          game.instance_variable_get(:@current_player_index)
        }.by(1)
      end
    end

    context 'when a turn is made and the current player wins' do
      it 'increases total move count by 1' do
        expect { game.user_turn }.to change { game.total_moves }.by(1)
      end

      it 'returns game win message' do
        game.instance_variable_set(:@total_moves, 6)
        allow(player).to receive(:check_winner).and_return(true)
        expect(game).to receive(:game_win_message).once
        game.user_turn
      end
    end
  end
end
