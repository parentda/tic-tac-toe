# frozen_string_literal: true

class Player
  @@player_number = 1
  attr_reader :name, :marker

  def initialize
    puts "Player #{@@player_number}, please enter your name: "
    @name = gets.chomp

    puts "Hello #{@name}, please enter a single character to serve as a marker for your chosen spaces: "
    @marker = gets.chomp
    until @marker.length == 1
      puts 'Please re-enter your marker choice and ensure that it is a single character: '
      @marker = gets.chomp
    end

    @@player_number += 1
  end
end
