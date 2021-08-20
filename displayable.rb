module Display
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
