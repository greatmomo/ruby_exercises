# frozen_string_literal: true

require 'pry-byebug'

# Player class stores name and symbol
class Player
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

# Board class stores and prints the current board state
class Board
  @@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def print_board
    puts
    puts "\t\t\t #{@@board[0]} | #{@@board[1]} | #{@@board[2]}"
    puts "\t\t\t---+---+---"
    puts "\t\t\t #{@@board[3]} | #{@@board[4]} | #{@@board[5]}"
    puts "\t\t\t---+---+---"
    puts "\t\t\t #{@@board[6]} | #{@@board[7]} | #{@@board[8]}"
    puts
  end

  def board
    @@board
  end

  def set_board(value, index)
    @@board[index] = value
  end
end

# Game loop and logic
class Game
  @@victory_state = false
  @@victor = 0
  @@current_player = 1
  @@player1 = Player.new('', '')
  @@player2 = Player.new('', '')

  def intro
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

  def game_loop
    until @@victory_state == true
      input = Game.play_prompt
      next unless input_valid?(input)

      Board.set_board((@@current_player == 1 ? @@player1.symbol : @@player2.symbol), (input.to_i - 1))
      Board.print_board
      @@current_player = @@current_player == 1 ? 2 : 1
      @@victory_state = game_over?
    end

    case @@victor
    when 0
      puts "It's a tie!"
    when 1
      puts "#{@@player1.name} wins!"
    when 2
      puts "#{@@player2.name} wins!"
    end

    # play again?
  end

  def self.play_prompt
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
    return true if Board.board[value - 1].is_a? Numeric

    false
  end

  def self.game_over?
    full_board = true
    Board.board.each do |value|
      if value.is_a? Numeric
        full_board = false
        break
      end
    end

    # check for victory state!
    if (Board.board[0] == @@player1.symbol && Board.board[1] == @@player1.symbol && Board.board[2] == @@player1.symbol) ||
       (Board.board[3] == @@player1.symbol && Board.board[4] == @@player1.symbol && Board.board[5] == @@player1.symbol) ||
       (Board.board[6] == @@player1.symbol && Board.board[7] == @@player1.symbol && Board.board[8] == @@player1.symbol) ||
       (Board.board[0] == @@player1.symbol && Board.board[3] == @@player1.symbol && Board.board[6] == @@player1.symbol) ||
       (Board.board[1] == @@player1.symbol && Board.board[4] == @@player1.symbol && Board.board[7] == @@player1.symbol) ||
       (Board.board[2] == @@player1.symbol && Board.board[5] == @@player1.symbol && Board.board[8] == @@player1.symbol) ||
       (Board.board[0] == @@player1.symbol && Board.board[4] == @@player1.symbol && Board.board[8] == @@player1.symbol) ||
       (Board.board[2] == @@player1.symbol && Board.board[4] == @@player1.symbol && Board.board[6] == @@player1.symbol)
      @@victor = 1
      return true
    elsif (Board.board[0] == @@player2.symbol && Board.board[1] == @@player2.symbol && Board.board[2] == @@player2.symbol) ||
          (Board.board[3] == @@player2.symbol && Board.board[4] == @@player2.symbol && Board.board[5] == @@player2.symbol) ||
          (Board.board[6] == @@player2.symbol && Board.board[7] == @@player2.symbol && Board.board[8] == @@player2.symbol) ||
          (Board.board[0] == @@player2.symbol && Board.board[3] == @@player2.symbol && Board.board[6] == @@player2.symbol) ||
          (Board.board[1] == @@player2.symbol && Board.board[4] == @@player2.symbol && Board.board[7] == @@player2.symbol) ||
          (Board.board[2] == @@player2.symbol && Board.board[5] == @@player2.symbol && Board.board[8] == @@player2.symbol) ||
          (Board.board[0] == @@player2.symbol && Board.board[4] == @@player2.symbol && Board.board[8] == @@player2.symbol) ||
          (Board.board[2] == @@player2.symbol && Board.board[4] == @@player2.symbol && Board.board[6] == @@player2.symbol)
      @@victor = 2
      return true
    end

    full_board
  end
end

# Game.intro
# Board.print_board
# Game.game_loop
