# Ask for player 1 name and symbol, save to class
# Repeat for player 2
# print board (with numbered fields), and ask player 1 to select one
# each round, switch players and check if valid (not yet played on)
# check for victory states (maybe have an array of possible victory arrays, if any match a player's array, then they win?)

require 'pry-byebug'

class Player
  def initialize(name, symbol, id)
    @name = name
    @symbol = symbol
    @id = id
  end
end



puts "Let's play Tic-Tac-Toe!"
puts
puts "What is the name of player #1?"
name = gets.chomp
puts "What 1 letter (or special character) would you like to be your game marker?"
symbol = gets.chomp
player1 = Player.new(name, symbol, 1)

puts "What is the name of player #2?"
name = gets.chomp
puts "What 1 letter (or special character) would you like to be your game marker?"
symbol = gets.chomp
player2 = Player.new(name, symbol, 2)

#binding.pry