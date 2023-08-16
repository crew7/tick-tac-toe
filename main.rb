# frozen_string_literal: false

require_relative 'game_board'
require_relative 'player'

game_board = GameBoard.new
game_board.generate_latest_game_board


player_one_pii = Player.fetch_player_one_pii
GameBoard.screen_clear
game_board.generate_latest_game_board
player_two_pii = Player.fetch_player_two_pii(player_one_pii)
