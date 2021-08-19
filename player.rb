# frozen_string_literal: true

class Player
  @@player_number = 1
  @@taken_markers = []

  attr_reader :name, :marker

  def initialize(board_size)
    @my_positions = {
      rows: Array.new(board_size, 0),
      columns: Array.new(board_size, 0),
      diag: Array.new(1, 0),
      anti_diag: Array.new(1, 0)
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
end
