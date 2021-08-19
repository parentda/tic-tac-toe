# frozen_string_literal: true

class Game
  def initialize(num_players, board_size)
    @num_players = num_players
    @board_size = board_size
    @players = Array.new(@num_players) { Player.new(@board_size) }
    @current_player_index = 0
    @board = Board.new(@board_size)
    @total_moves = 0
  end

  def play; end
end
