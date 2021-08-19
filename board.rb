# frozen_string_literal: true

class Board
  attr_accessor :positions

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @positions = Array.new(@rows) { Array.new(@columns) }
  end

  def validate_move(board_position, marker)
    row = board_position / @rows
    column = board_position % @columns
    @positions[row][column].nil? ? @positions[row][column] = marker : false
  end

  def draw_board
    p @positions
  end

  def check_winner; end
end
