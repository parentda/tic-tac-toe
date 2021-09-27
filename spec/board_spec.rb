require_relative '../lib/board'

describe Board do
  describe '#validate_move' do
    let(:marker) { 'X' }
    let(:board_size) { 3 }
    subject(:game_board) { described_class.new(board_size) }

    context 'when user enters a valid, unmarked position' do
      it 'returns the row and column' do
        coords = game_board.validate_move(marker, 5)
        expect(coords).to eq([1, 2])
      end

      it 'marks the corresponding position as taken' do
        game_board.validate_move(marker, 5)
        expect(game_board.positions[1][2]).to_not be_nil
      end
    end

    context 'when user enters a marked position' do
      before do
        game_board.instance_variable_set(
          :@positions,
          Array.new(board_size, marker) { Array.new(board_size, marker) }
        )
      end
      it 'returns false' do
        coords = game_board.validate_move(marker, 5)
        expect(coords).to be false
      end
    end
  end
end
