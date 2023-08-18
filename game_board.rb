# frozen_string_literal: false

# Creates, keeps track, and updates the game board
class GameBoard
  def initialize
    self.position_one = '1'
    self.position_two = '2'
    self.position_three = '3'
    self.position_four = '4'
    self.position_five = '5'
    self.position_six = '6'
    self.position_seven = '7'
    self.position_eight = '8'
    self.position_nine = '9'
  end

  def generate_latest_game_board
    print "\n"
    create_outer_row
    puts "| #{position_one} | #{position_two} | #{position_three} |"
    create_inner_row
    puts "| #{position_four} | #{position_five} | #{position_six} |"
    create_inner_row
    puts "| #{position_seven} | #{position_eight} | #{position_nine} |"
    create_outer_row
  end

  def create_outer_row
    puts '-' * 13
  end

  def create_inner_row
    puts "#{'-' * 4}+#{'-' * 3}+#{'-' * 4}"
  end

  def retrieve_player_pii(player_one_pii, player_two_pii)
    self.player_one_pii = player_one_pii
    self.player_two_pii = player_two_pii
  end

  def refresh_board
    screen_clear
    generate_latest_game_board
  end

  def screen_clear
    puts "\e[H\e[2J"
  end

  def receive_placement_request(value)
    
  end

  private

  attr_accessor :position_one, :position_two, :position_three,
                :position_four, :position_five, :position_six,
                :position_seven, :position_eight, :position_nine,
                :player_one_pii, :player_two_pii
end
