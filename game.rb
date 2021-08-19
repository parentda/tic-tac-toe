# frozen_string_literal: true

class Game
  def initialize(num_players, size)
    @num_players = num_players
    @players = Array.new(@num_players) { Player.new }
    @current_player_index = 0
    @size = size
    @board = Board.new(@size, @size)
  end
end
