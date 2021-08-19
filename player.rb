# frozen_string_literal: true

class Player
  @@player_number = 1
  @@taken_markers = []

  attr_reader :name, :marker, :my_positions

  def initialize(board_size)
    @my_positions = {
      rows: Array.new(board_size, 0),
      columns: Array.new(board_size, 0),
      diag: 0,
      anti_diag: 0
    }

    puts "Player #{@@player_number}, please enter your name: "
    @name = gets.chomp

    puts "Hello #{@name}, please enter a single character to serve as a marker for your chosen spaces: "
    @marker = gets.chomp
    until @marker.length == 1 && !@@taken_markers.include?(@marker)
      puts 'Please re-enter your marker choice and ensure that it is a single character that is not already being used by another player: '
      @marker = gets.chomp
    end
    @@taken_markers << @marker

    @@player_number += 1
  end

  def update_my_positions(row, column, board_size)
    @my_positions[:rows][row] += 1
    @my_positions[:columns][column] += 1
    if row == column
      @my_positions[:diag] += 1
    elsif row + column == board_size - 1
      @my_positions[:anti_diag] += 1
    end
  end
end
