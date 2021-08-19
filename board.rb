# frozen_string_literal: true

class Board
  attr_accessor :positions

  def initialize(board_size)
    @board_size = board_size
    @indentation = 8
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
      @positions[row][column] = player.marker
      player.update_my_positions(row, column, @board_size)
      true
    else
      false
    end
  end

  def draw_board
    placeholder = 1
    string = ' ' * @indentation
    @positions.each do |row|
      string += "#{'+---' * @board_size}+\n#{' ' * @indentation}"
      row.each do |item|
        val = item || placeholder
        string += "| #{val} "
        placeholder += 1
      end
      string += "|\n#{' ' * @indentation}"
    end
    string += "#{'+---' * @board_size}+"
    string
  end
end
