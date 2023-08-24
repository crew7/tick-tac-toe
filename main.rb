# frozen_string_literal: false

require_relative 'game_board'
require_relative 'player'

def create_game_board
  game_board = GameBoard.new
  game_board.refresh_board
  game_board
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

    if result.instance_of? Hash
      game_board.refresh_board
      return result
    end

    break if result == true
  end
  game_board.refresh_board
end

def player_two_request(player_two, game_board)
  loop do
    player_two_placement_request = player_two.action
    result = game_board.receive_placement_request(player_two_placement_request)

    if result.instance_of? Hash
      game_board.refresh_board
      return result
    end

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
    game_state = player_one_request(player_one, game_board)
    break if game_state.instance_of? Hash

    game_state = player_two_request(player_two, game_board)
    break if game_state.instance_of? Hash

  end

  puts "There is a winner."
  exit
end
