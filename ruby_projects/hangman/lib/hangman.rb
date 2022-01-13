# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'game'
require_relative 'display'

include Display

victory_state = ''

def game_loop
  game = game_prompt
  while game.turn <= 8
    input = turn_text(game)
    if input == 'save'
      # save game state
      break
    end
    next unless input.match?(/[[:alpha:]]/) && input.length == 1 && !game.guesses.include?(input.upcase)
    game.guesses.push(input.upcase)
    victory_state = 'v' if game.all_guessed?
    game.turn = game.turn + 1
  end
  puts game.print_state
end

def game_prompt
  puts display_game_prompt
  input = gets.chomp
  if input == '1'
    return Game.new
  elsif input == '2'
    return load_game
  else
    game_prompt
  end
end

def load_game
  # return the game state from a valid file
  Game.new
end

def turn_text(game)
  puts game.print_state
  print "Turn #{game.turn} - "
  print display_guess_prompt
  input = gets.chomp
end

puts display_intro
game_loop

if victory_state == 'v'
  puts "Congratulations! You won!"
else
  puts "Aww. Better luck next time!"
end

# Save game state if user enters 'save'
# Add ability to load a game state
