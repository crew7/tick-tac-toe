# frozen_string_literal: false

# Creates, keeps track, and updates the game board
class GameBoard
  def initialize
    self.positions = (1..9).to_a
  end

  def generate_latest_game_board
    print "\n"
    create_outer_row
    puts "| #{positions[0]} | #{positions[1]} | #{positions[2]} |"
    create_inner_row
    puts "| #{positions[3]} | #{positions[4]} | #{positions[5]} |"
    create_inner_row
    puts "| #{positions[6]} | #{positions[7]} | #{positions[8]} |"
    create_outer_row
  end

  def create_outer_row
    puts '-' * 13
  end

  def create_inner_row
    puts "#{'-' * 4}+#{'-' * 3}+#{'-' * 4}"
  end

  def refresh_board
    screen_clear
    generate_latest_game_board
  end

  def screen_clear
    puts "\e[H\e[2J"
  end

  def receive_placement_request(request_data)
    requested_piece = request_data[:player_piece]
    requested_number = request_data[:placement_request].to_i - 1
    target_location = positions[requested_number]

    if target_location != 'x' || target_location != 'o'
      positions[requested_number] = requested_piece
      true
    else
      puts "This target is already taken. Try again.\n\n"
      false
    end
  end

  private

  attr_accessor :positions
end
