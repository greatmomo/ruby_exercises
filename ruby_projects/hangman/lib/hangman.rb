# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'game'
require_relative 'display'

require 'yaml'

def game_loop
  game = game_prompt
  while game.turn <= 
    input = turn_text(game)
    return save_game(game) if input == 'save'
    next unless input.match?(/[[:alpha:]]/) && input.length == 1 && !game.guesses.include?(input.upcase)

    game.guesses.push(input.upcase)
    return 'v' if game.all_guessed?

    game.turn = game.turn + 1 unless game.word_to_guess.include? input.upcase
  end
  puts game.print_state
  ''
end

def game_prompt
  puts display_game_prompt
  input = gets.chomp
  case input
  when '1'
    Game.new
  when '2'
    load_game
  else
    game_prompt
  end
end

def save_game(game)
  print display_filename_prompt
  file_name = gets.chomp
  File.open(file_name, 'w') { |file| file.write(game.to_yaml) }
  's'
end

def load_game
  print display_filename_prompt
  file_name = gets.chomp
  file = File.open(file_name, 'r')
  data = file.read
  YAML.safe_load(data)
end

def turn_text(game)
  puts game.print_state
  print "Turn #{game.turn} - "
  print display_guess_prompt
  gets.chomp
end

puts display_intro
victory_state = game_loop

case victory_state
when 'v'
  puts 'Congratulations! You won!'
when 's'
  puts 'File saved.'
else
  puts 'Aww. Better luck next time!'
end

# Save game state if user enters 'save'
# Add ability to load a game state
