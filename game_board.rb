# frozen_string_literal: false

# Creates and updates the game board
class GameBoard
  def generate_latest_game_board
    print "\n"
    create_outer_row
    puts '| x | x | x |'
    create_inner_row
    puts '| x | x | x |'
    create_inner_row
    puts '| x | x | x |'
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
end
