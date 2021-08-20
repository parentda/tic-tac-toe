# frozen_string_literal: true

require_relative 'displayable'
class Game
  include Display
  attr_accessor :board

  def initialize(num_players, board_size)
    @num_players = num_players
    @board_size = board_size
    @board_limits = [1, @board_size**2]
    @min_moves = @board_size * 2 - 1
    @max_moves = @board_size**2
    @board = Board.new(@board_size)
    @current_player_index = 0
    @total_moves = 0
    @game_win = false
  end

  def setup
    segment_break_message
    intro_message
    @players = Array.new(@num_players) { Player.new(@board_size) }
  end

  def play
    game_start_message
    while @total_moves < @max_moves
      current_player = @players[@current_player_index]
      next_turn_message(current_player)
      row_col = user_move(current_player)
      current_player.update_my_positions(row_col[0], row_col[1], @board_size)
      puts "\n#{@board.draw_board}\n\n"

      @total_moves += 1
      @game_win = current_player.check_winner(@board_size) if @total_moves >=
        @min_moves
      break game_win_message(current_player) if @game_win == true

      @current_player_index = (@current_player_index + 1) % @num_players
    end
    game_tie_message unless @game_win
  end

  def user_move(player)
    while (move = gets.chomp.to_i)
      row_col = @board.validate_move(player, move - 1) if move.between?(
        @board_limits[0],
        @board_limits[1]
      )
      break row_col if row_col

      invalid_selection_message(player)
    end
  end
end
