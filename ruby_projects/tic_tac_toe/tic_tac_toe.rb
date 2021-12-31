# frozen_string_literal: true

# each round, switch players and check if valid (not yet played on)
# check for victory states
# use array of possible victory states and compare to symbols

require 'pry-byebug'

# Player class stores name and symbol
class Player
  attr_accessor :name
  attr_accessor :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

# Board class stores and prints the current board state
class Board
  @@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def self.print_board
    puts
    puts "\t\t\t #{@@board[0]} | #{@@board[1]} | #{@@board[2]}"
    puts "\t\t\t---+---+---"
    puts "\t\t\t #{@@board[3]} | #{@@board[4]} | #{@@board[5]}"
    puts "\t\t\t---+---+---"
    puts "\t\t\t #{@@board[6]} | #{@@board[7]} | #{@@board[8]}"
    puts
  end

  def self.board
    @@board
  end

  def self.set_board(value, index)
    @@board[index] = value
  end
end

# Game loop and logic
class Game
  @@victory_state = false
  @@current_player = 1
  @@player1 = Player.new('', '')
  @@player2 = Player.new('', '')

  def self.intro
    puts "Let's play Tic-Tac-Toe!"
    puts
    puts 'What is the name of player #1?'
    name = gets.chomp
    puts 'What 1 letter (or special character) would you like to be your game marker?'
    symbol = gets.chomp
    @@player1 = Player.new(name, symbol)

    puts 'What is the name of player #2?'
    name = gets.chomp
    puts 'What 1 letter (or special character) would you like to be your game marker?'
    symbol = gets.chomp
    @@player2 = Player.new(name, symbol)
  end

  def self.game_loop
    until @@victory_state == true
      input = Game.play_prompt
      next unless input_valid?(input)
      Board.set_board((@@current_player == 1 ? @@player1.symbol : @@player2.symbol), (input.to_i - 1))
      Board.print_board
      @@current_player == 1? @@current_player = 2 : @@current_player = 1
    end
  end

  def Game.play_prompt
    if @@current_player == 1
      puts "#{@@player1.name}, enter the number where you want to play:"
    else
      puts "#{@@player2.name}, enter the number where you want to play:"
    end
    gets.chomp
  end

  def self.input_valid?(value)
    return false unless value.length == 1
    value = value.to_i
    # check if value is 1-9
    return false unless value >= 1 && value <= 9
    if Board.board[value - 1].is_a? Numeric
      return true
    end
    false
  end
end

Game.intro

Board.print_board

Game.game_loop

# binding.pry
