require_relative 'game_board'

def fetch_player_one_data(player_data)
    puts 'The second player gets the leftover piece.'
    puts 'What is the first players name?'
    player_one_name = gets.chomp.capitalize
    while true
      print "\nWill you be playing as 'X' or 'O' #{player_one_name}?\n"
      player_one_piece = gets.chomp.downcase
      if player_one_piece.eql?('x') || player_one_piece.eql?('o')
        break
      else
        puts "Invalid input of '#{player_one_piece}', you didn't enter 'X' or 'O'"
      end
    end
    player_data[:player_one_name] = player_one_name
    player_data[:player_one_piece] = player_one_piece
    player_data
end

def fetch_player_two_data(player_data)
    player_one_name = player_data[:player_one_name]
    player_one_piece = player_data[:player_one_piece]

    puts "\nWhat is the second players name?"
    player_two_name = gets.chomp.capitalize
    case player_one_piece
    when 'x'
      print "\nSince #{player_one_name} is using the 'X' piece, #{player_two_name} will be using the 'O' piece.\n"
      player_two_piece = 'x'
    when 'o'
      print "\nSince #{player_one_name} is using the 'O' piece, #{player_two_name} will be using the 'X' piece.\n"
      player_two_piece = 'o'
    end

    player_data[:player_two_name] = player_two_name
    player_data[:player_two_piece] = player_two_piece

    player_data
end