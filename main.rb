require_relative "game_board.rb"


game = GameBoard.new
game.generate_game_board

puts "What is the first players name?\n\n"
player1_name = gets
