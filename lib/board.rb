# frozen_string_literal: true

class Board
  attr_accessor :positions

  def initialize(board_size)
    @board_size = board_size
    @indentation = ' ' * 8
    @positions = Array.new(@board_size) { Array.new(@board_size) }
  end

  def validate_move(marker, board_position)
    row = board_position / @board_size
    column = board_position % @board_size

    if @positions[row][column].nil?
      @positions[row][column] = marker
      [row, column]
    else
      false
    end
  end

  def draw_board
    placeholder = 1
    string = @indentation
    @positions.each do |row|
      string += "#{'+---' * @board_size}+\n#{@indentation}"
      row.each do |item|
        string += item ? "| \e[1m#{item}\e[0m " : "| #{placeholder} "
        placeholder += 1
      end
      string += "|\n#{@indentation}"
    end
    string += "#{'+---' * @board_size}+"
  end
end
