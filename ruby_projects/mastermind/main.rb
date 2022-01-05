# frozen_string_literal: true

require_relative 'game'
require_relative 'display'

require 'colorize'

def play_game
  game = Game.new
  game.play
  repeat_game
end

def repeat_game
  puts "Would you like to play a new game? Press 'y' for yes, or any other character for no."
  repeat_input = gets.chomp.downcase
  if repeat_input == 'y'
    play_game
  else
    puts 'Thanks for playing!'
  end
end

play_game
