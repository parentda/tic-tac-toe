# frozen_string_literal: true

class Game
  attr_accessor :board

  def initialize(num_players, board_size)
    @num_players = num_players
    @board_size = board_size
    @board_limits = [1, @board_size**2]
    @min_moves = @board_size * 2 - 1
    @max_moves = @board_size**2
    @board = Board.new(@board_size)
    segment_break_message
    intro_message
    @players = Array.new(@num_players) { Player.new(@board_size) }
    @current_player_index = 0
    @total_moves = 0
    @game_win = false
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

  def intro_message
    puts <<~HEREDOC

      Welcome to Tic-Tac-Toe!

      The rules are simple: Be the first player to mark 3 spaces in a row (vertically, horizontally, or diagonally)

      The board is shown below:

      #{@board.draw_board}

      Two players are required, and to mark a space simply input the number occupying that space on the board above.

      Before we get started, we just need to know who will be playing today.

    HEREDOC
  end

  def game_start_message
    puts <<~HEREDOC
      Excellent! Let's get started.

      #{@board.draw_board}

    HEREDOC
  end

  def next_turn_message(player)
    print "#{player.name}, please select an unmarked space: "
  end

  def game_win_message(player)
    puts "Congratulations #{player.name}, you have won the game!\n\n"
  end

  def game_tie_message
    puts "The game ends in a draw!\n\n"
  end

  def invalid_selection_message(player)
    print "Sorry #{player.name}, that is not a valid selection. Please ensure you select an unmarked space: "
  end

  def segment_break_message
    puts "\n#{'+---' * 30}+"
  end
end
