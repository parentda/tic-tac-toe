# frozen_string_literal: true

class Game
  attr_accessor :board

  def initialize(num_players, board_size)
    @num_players = num_players
    @board_size = board_size
    @board = Board.new(@board_size)
    intro_message
    @players = Array.new(@num_players) { Player.new(@board_size) }
    @current_player_index = 0
    @total_moves = 0
    @game_over = false
  end

  def play; end

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
    puts "#{player.name}, please select an unmarked space: "
  end

  def game_over_message(player)
    puts "Congratulations #{player.name}, you have won the game!"
  end
end
