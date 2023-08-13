# frozen_string_literal: false

require_relative 'game_board'

def fetch_players_data
  puts 'The second player gets the leftover piece.'
  puts 'What is the first players name?'
  player_one_name = gets.chomp
  while true
    print "\nWill you be playing as 'X' or 'O' #{player_one_name}?\n"
    player_one_piece = gets.chomp.downcase
    if player_one_piece.eql?('x') || player_one_piece.eql?('o')
      break
    else
      puts "Invalid input of #{player_one_piece}, you didn't enter 'X' or 'O'"
    end
  end

  puts "\nWhat is the second players name?"
  player_two_name = gets.chomp
  case player_one_piece
  when 'x'
    print "\nSince #{player_one_name} is using 'X', you will be 'O', #{player_two_name}.\n"
    player_two_piece = 'x'
  when 'o'
    print "\nSince #{player_one_name} is using 'O', you will be 'X', #{player_two_name}.\n"
    player_two_piece = 'o'
  end
end

game = GameBoard.new
game.generate_game_board
fetch_players_data()