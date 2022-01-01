# frozen_string_literal: true

require_relative 'game.rb'
require_relative 'display.rb'

require 'colorize'

def play_game
  game = Game.new
  game.play
  repeat_game
end

def repeat_game
  puts "Would you like to play a new game? Press 'y' for yes, or any other character for no.".on_light_blue
  repeat_input = gets.chomp.downcase
  if repeat_input == 'y'
    play_game
  else
    puts 'Thanks for playing!'.on_light_magenta
  end
end

play_game

puts String.colors