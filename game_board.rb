# frozen_string_literal: true

# Creates, keeps track, and updates the game board
class GameBoard
  def initialize
    self.positions = (1..9).to_a
  end

  def check_win_con(piece)
    # I check each win con here via loops vertically, horizontally and diagonally.
    check_column_win_con(piece) || check_row_win_con(piece) || check_diagonal_win_con(piece)
  end

  def check_diagonal_win_con(piece)
    left_diagonal = 0
    winner = true
    winner = false unless positions[left_diagonal] == piece
    2.times do
      left_diagonal += 4
      winner = false unless positions[left_diagonal] == piece
    end
    return winner if winner == true

    right_diagonal = 2
    winner = true
    winner = false unless positions[right_diagonal] == piece
    2.times do
      right_diagonal += 2
      winner = false unless positions[right_diagonal] == piece
    end
    winner
  end

  def check_row_win_con(piece)
    winner = true
    [0, 3, 6].each do |row|
      winner = true
      winner = false unless positions[row] == piece
      2.times do
        row += 1
        winner = false unless positions[row] == piece
      end
      return true if winner == true
    end
    winner
  end

  def check_column_win_con(piece)
    winner = true
    (0..2).to_a.each do |column|
      winner = true # Had to be declared before, but also has to be declared beginning of each loop.
      winner = false unless positions[column] == piece
      2.times do
        column += 3
        winner = false unless positions[column] == piece
      end
      return true if winner == true
    end
    winner
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

  def reset_board
    self.positions = (1..9).to_a
    refresh_board
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
    requested_number = request_data[:placement_request]
    requested_index = request_data[:placement_request].to_i - 1
    target_location = positions[requested_index]

    if target_location != 'X' && target_location != 'O'
      positions[requested_index] = requested_piece

      tie = true
      positions.each do |position| # Check if tie
        tie = false if position != 'X' && position != 'O'
      end
      return 'tie' if tie == true

      return request_data if check_win_con(requested_piece) # Check if someone won

      true
    else
      refresh_board # Incorrect input, retry input
      puts "The target of #{requested_number} is already taken. Try again.\n\n"
      false
    end
  end

  private

  def create_outer_row
    puts '-' * 13
  end

  def create_inner_row
    puts "#{'-' * 4}+#{'-' * 3}+#{'-' * 4}"
  end

  attr_accessor :positions
end
