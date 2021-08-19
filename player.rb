# frozen_string_literal: true

class Player
  attr_reader :name, :symbol

  def initialize(player_number)
    puts "Player #{player_number}, please enter your name: "
    @name = gets.chomp
    puts "Hello #{@name}, please enter a single character to serve as a marker for your chosen spaces: "
    @symbol = gets.chomp
    until @symbol.length == 1
      puts 'Please re-enter your marker choice and ensure that it is a single character: '
      @symbol = gets.chomp
    end
  end
end
