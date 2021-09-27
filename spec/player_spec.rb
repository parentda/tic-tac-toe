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
    before do
      allow(input_marker).to receive(:puts)
      allow(input_marker).to receive(:print)
    end

    context 'when user inputs a valid marker' do
      before { allow(input_marker).to receive(:gets).and_return('X') }

      it 'stops loop and does not display error message' do
        expect(input_marker).not_to receive(:print).with(error_message)
        input_marker.parse_marker
      end
    end

    context 'when user inputs an invalid marker once, then a valid marker' do
      before { allow(input_marker).to receive(:gets).and_return('X', 'Y') }

      it 'stops loop and does not display error message' do
        expect(input_marker).to receive(:print).with(error_message).once
        input_marker.parse_marker
      end
    end

    context 'when user inputs an invalid marker twice, then a valid marker' do
      before { allow(input_marker).to receive(:gets).and_return('X', 'Y', 'Z') }

      it 'stops loop and does not display error message' do
        expect(input_marker).to receive(:print).with(error_message).twice
        input_marker.parse_marker
      end
    end
  end

  describe '.update_taken_markers' do
    subject(:update_markers) { described_class }

    context 'when a valid marker is given' do
      let(:input) { 'X' }
      it 'adds marker to @@taken_markers' do
        expect { update_markers.update_taken_markers(input) }.to change {
          update_markers.taken_markers.length
        }.by(1)
      end

      it 'returns marker' do
        valid_marker = update_markers.update_taken_markers(input)
        expect(valid_marker).to eq(input)
      end
    end
  end

  describe '#update_my_positions' do
    let(:board_size) { 3 }
    subject(:player_positions) { described_class.new(board_size) }
    before do
      allow(described_class).to receive(:parse_name).and_return('Dan')
      allow(described_class).to receive(:parse_marker).and_return('X')
    end

    context 'when a move is played that is on both the diag and anti-diag' do
      it 'increases rows, columns, diag, and anti-diag by 1' do
        row = 1
        col = 1
        expect {
          player_positions.update_my_positions(row, col, board_size)
        }.to change { player_positions.my_positions[:rows][row] }.by(
          1
        ).and change { player_positions.my_positions[:columns][col] }.by(
                           1
                         ).and change { player_positions.my_positions[:diag] }
                                            .by(1).and change {
                                                             player_positions
                                                               .my_positions[
                                                               :anti_diag
                                                             ]
                                                           }.by(1)
      end
    end

    context 'when a move is played that is on only the diag' do
      it 'increases rows, columns, and diag by 1' do
        row = 0
        col = 0
        expect {
          player_positions.update_my_positions(row, col, board_size)
        }.to change { player_positions.my_positions[:rows][row] }.by(
          1
        ).and change { player_positions.my_positions[:columns][col] }.by(
                           1
                         ).and change { player_positions.my_positions[:diag] }
                                            .by(1).and change {
                                                             player_positions
                                                               .my_positions[
                                                               :anti_diag
                                                             ]
                                                           }.by(0)
      end
    end

    context 'when a move is played that is on only the anti-diag' do
      it 'increases rows, columns, and anti-diag by 1' do
        row = 0
        col = 2
        expect {
          player_positions.update_my_positions(row, col, board_size)
        }.to change { player_positions.my_positions[:rows][row] }.by(
          1
        ).and change { player_positions.my_positions[:columns][col] }.by(
                           1
                         ).and change { player_positions.my_positions[:diag] }
                                            .by(0).and change {
                                                             player_positions
                                                               .my_positions[
                                                               :anti_diag
                                                             ]
                                                           }.by(1)
      end
    end

    context 'when a move is played that on enither the diag or anti-diag' do
      it 'increases rows and columns only' do
        row = 0
        col = 1
        expect {
          player_positions.update_my_positions(row, col, board_size)
        }.to change { player_positions.my_positions[:rows][row] }.by(
          1
        ).and change { player_positions.my_positions[:columns][col] }.by(
                           1
                         ).and change { player_positions.my_positions[:diag] }
                                            .by(0).and change {
                                                             player_positions
                                                               .my_positions[
                                                               :anti_diag
                                                             ]
                                                           }.by(0)
      end
    end
  end

  describe '#check_winner' do
    let(:board_size) { 3 }
    subject(:player_win) { described_class.new(board_size) }
    before do
      allow(described_class).to receive(:parse_name).and_return('Dan')
      allow(described_class).to receive(:parse_marker).and_return('X')
    end

    context 'when player has 3 successive positions' do
      before do
        player_win.instance_variable_set(
          :@my_positions,
          { rows: [0, 1, 2], columns: [3, 0, 0], diag: 0, anti_diag: 0 }
        )
      end
      it 'returns true' do
        win_check = player_win.check_winner(board_size)
        expect(win_check).to be true
      end
    end

    context 'when player does not have 3 successive positions' do
      before do
        player_win.instance_variable_set(
          :@my_positions,
          { rows: [0, 1, 2], columns: [2, 0, 2], diag: 2, anti_diag: 1 }
        )
      end
      it 'returns false' do
        win_check = player_win.check_winner(board_size)
        expect(win_check).to be false
      end
    end
  end

  describe '#reset' do
  end
end
