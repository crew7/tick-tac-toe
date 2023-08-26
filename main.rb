# frozen_string_literal: false

require_relative 'game_board'
require_relative 'player'

def create_game_board
  game_board = GameBoard.new
  game_board.refresh_board
  game_board
end

def play_again?
  puts "Would you like to play again? (y/n)\n\n"
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

def choice_loop(player_one, player_two, game_board)
  loop do # while to retain game_state for either tie or winner
    game_state = player_one_request(player_one, game_board)
    return game_state if game_state.instance_of? Hash # Hash would contain winners data
    return game_state if game_state == 'tie'

    game_state = player_two_request(player_two, game_board)
    return game_state if game_state.instance_of? Hash
    return game_state if game_state == 'tie'
  end
end

def reverse_choice_loop(player_one, player_two, game_board)
  loop do # while to retain game_state for either tie or winner
    game_state = player_two_request(player_two, game_board)
    return game_state if game_state.instance_of? Hash
    return game_state if game_state == 'tie'

    game_state = player_one_request(player_one, game_board)
    return game_state if game_state.instance_of? Hash # Hash would contain winners data
    return game_state if game_state == 'tie'
  end
end

loop do
  game_board = create_game_board
  player_one_arr = create_player_one(game_board)
  player_one = player_one_arr[0]
  player_one_pii = player_one_arr[1]
  player_two = create_player_two(game_board, player_one_pii)

  first_choice_counter = 1 # This variable is so players alternate first choice to make the game fair.
  loop do
    if first_choice_counter.odd?
      game_state = choice_loop(player_one, player_two, game_board)
    elsif first_choice_counter.even?
      game_state = reverse_choice_loop(player_one, player_two, game_board)
    end

    if game_state.instance_of? Hash
      game_board.refresh_board
      puts "Congratuations #{game_state[:player_name]}! you have won."
      if play_again?
        first_choice_counter += 1
        game_board.reset_board
        redo
      else
        exit
      end
    elsif game_state == 'tie'
      game_board.refresh_board
      puts 'Tie game, no winner.'
      if play_again?
        first_choice_counter += 1
        game_board.reset_board
        redo
      else
        exit
      end
    end
  end
end
