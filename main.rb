# frozen_string_literal: false

require_relative 'game_board'
require_relative 'player'

def create_game_board
  game_board = GameBoard.new
  game_board.refresh_board
  game_board
end

def play_again?
  puts 'Would you like to play again? (y/n)'
  while true
    play_again = gets.chomp.downcase
    if play_again == 'y' || play_again == 'n'
      break  
    else
      puts "\nYou didn't enter 'y' for yes, or 'n' for no. Please try again.\n\n"
    end
  end
  play_again == 'y'
end

def create_player_one(game_board)
  player_one_pii = Player.fetch_player_one_pii
  player_one = Player.new(player_one_pii)
  game_board.refresh_board
  [player_one, player_one_pii]
end

def create_player_two(game_board, player_one_pii)
  player_two_pii = Player.fetch_player_two_pii(player_one_pii)
  player_two = Player.new(player_two_pii)
  game_board.refresh_board
  player_two
end

def player_one_request(player_one, game_board)
  loop do
    player_one_placement_request = player_one.action
    result = game_board.receive_placement_request(player_one_placement_request)

    return result if result.instance_of? Hash
    return result if result == 'tie'

    break if result == true
  end
  game_board.refresh_board
end

def player_two_request(player_two, game_board)
  loop do
    player_two_placement_request = player_two.action
    result = game_board.receive_placement_request(player_two_placement_request)

    return result if result.instance_of? Hash
    return result if result == 'tie'

    break if result == true
  end
  game_board.refresh_board
end

loop do
  game_board = create_game_board
  player_one_arr = create_player_one(game_board)
  player_one = player_one_arr[0]
  player_one_pii = player_one_arr[1]
  player_two = create_player_two(game_board, player_one_pii)

  loop do
    while true # while to retain game_state for either tie or winner
      game_state = player_one_request(player_one, game_board)
      break if game_state.instance_of? Hash # Hash would contain winners data
      break if game_state == 'tie'

      game_state = player_two_request(player_two, game_board)
      break if game_state.instance_of? Hash
      break if game_state == 'tie'
    end

    if game_state.instance_of? Hash
      game_board.refresh_board
      puts "Congratuations #{game_state[:player_name]}! you have won."
      play_again? == true ? redo : exit
    elsif game_state == 'tie'
      game_board.refresh_board
      puts 'Tie game, no winner.'
      play_again? == true ? redo : exit
    end
  end
end
