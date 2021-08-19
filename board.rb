# frozen_string_literal: true

class Board
  attr_accessor :positions

  def initialize(board_size)
    @board_size = board_size
    @board_limits = [0, @board_size**2 - 1]
    @positions = Array.new(@board_size) { Array.new(@board_size) }
  end

  def validate_move(player, board_position)
    unless board_position.between?(@board_limits[0], @board_limits[1])
      return false
    end

    row = board_position / @board_size
    column = board_position % @board_size

    if @positions[row][column].nil?
      @total_moves += 1
      @positions[row][column] = player.marker
      [row, column]
    else
      false
    end
  end

  def draw_board
    p @positions
  end

  def check_winner(row, column)
    puts 'Checking winner'
  end
end
