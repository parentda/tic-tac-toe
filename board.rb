# frozen_string_literal: true

class Board
  attr_accessor :positions

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @positions = Array.new(@rows) { Array.new(@columns) }
  end

  def validate_move(board_position); end

  def draw_board; end

  def check_winner; end
end
