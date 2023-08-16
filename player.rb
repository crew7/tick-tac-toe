require_relative 'game_board'

class Player
    def initialize(player_pii)
        @player_name = player_pii[:player_name]
        @player_piece = player_pii[:player_piece]
    end



    def self.fetch_player_one_pii
        player_one_pii = {}
        puts "The second player gets the leftover piece."
        puts 'What is the first players name?'
        player_one_name = gets.chomp.capitalize
        while true
          print "\nWill you be playing as 'X' or 'O', #{player_one_name}?\n"
          player_one_piece = gets.chomp.downcase
          if player_one_piece.eql?('x') || player_one_piece.eql?('o')
            break
          else
            puts "Invalid input of '#{player_one_piece}', you didn't enter 'X' or 'O'"
          end
        end
        player_one_pii[:player_name] = player_one_name
        player_one_pii[:player_piece] = player_one_piece
        player_one_pii
    end
    
    def self.fetch_player_two_pii(player_one_pii)
        player_one_name = player_one_pii[:player_name]
        player_one_piece = player_one_pii[:player_piece]
    
        puts "\nWhat is the second players name?"
        player_two_name = gets.chomp.capitalize
        case player_one_piece
        when 'x'
          print "\nSince #{player_one_name} is using the 'X' piece, #{player_two_name} will be using the 'O' piece.\n"
          player_two_piece = 'o'
        when 'o'
          print "\nSince #{player_one_name} is using the 'O' piece, #{player_two_name} will be using the 'X' piece.\n"
          player_two_piece = 'x'
        end
    
        player_two_pii = {}
        player_two_pii[:player_name] = player_two_name
        player_two_pii[:player_piece] = player_two_piece
    
        player_two_pii
    end
end

