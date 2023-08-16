# frozen_string_literal: false

require_relative 'game_board'
require_relative 'player'

game_board = GameBoard.new
game_board.generate_latest_game_board

player_data = {}
player_data = fetch_player_one_data(player_data)
GameBoard.screen_clear
game_board.generate_latest_game_board
player_data = fetch_player_two_data(player_data)