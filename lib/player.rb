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
    @name = Player.parse_name
    @marker = Player.parse_marker
    @@player_number += 1
  end

  def self.parse_name
    print "Player #{@@player_number}, please enter your name: "
    gets.chomp
  end

  def self.parse_marker
    print "Hello #{@name}, please enter a single character to serve as a marker for your chosen spaces: "
    while (marker = gets.chomp)
      break if marker.length == 1 && !@@taken_markers.include?(marker)

      print 'Please re-enter your marker choice and ensure that it is a single character that is not already in use: '
    end
    puts "Thank you!\n\n"
    @@taken_markers << marker
    marker
  end

  def self.player_number
    @@player_number
  end

  def update_my_positions(row, column, board_size)
    @my_positions[:rows][row] += 1
    @my_positions[:columns][column] += 1
    @my_positions[:diag] += 1 if row == column
    @my_positions[:anti_diag] += 1 if row + column == board_size - 1
  end

  def check_winner(board_size)
    @my_positions.values.flatten.include?(board_size)
  end

  def self.reset
    @@player_number = 1
    @@taken_markers = []
  end
end
