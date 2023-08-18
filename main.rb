# frozen_string_literal: false

require_relative 'game_board'
require_relative 'player'

game_board = GameBoard.new
game_board.refresh_board

player_one_pii = Player.fetch_player_one_pii
game_board.refresh_board
player_two_pii = Player.fetch_player_two_pii(player_one_pii)

player_one = Player.new(player_one_pii)
player_two = Player.new(player_two_pii)


game_board.refresh_board
player_one_placement_request = player_one.action
game_board.receive_placement_request(player_one_placement_request)
game_board.refresh_board