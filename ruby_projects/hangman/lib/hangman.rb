# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'game'
require_relative 'display'

require 'yaml'

include Display

victory_state = ''

def game_loop
  game = game_prompt
  while game.turn <= 8
    input = turn_text(game)
    if input == 'save'
      print display_filename_prompt      
      file_name = gets.chomp
      File.open(file_name, 'w') { |file| file.write(game.to_yaml) }
      return 's'
      break
    end
    next unless input.match?(/[[:alpha:]]/) && input.length == 1 && !game.guesses.include?(input.upcase)
    game.guesses.push(input.upcase)
    return 'v' if game.all_guessed?
    game.turn = game.turn + 1 if !game.word_to_guess.include? input.upcase
  end
  puts game.print_state
  return ''
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
  print display_filename_prompt
  file_name = gets.chomp
  file = File.open(file_name, 'r')
  data = file.read
  YAML::load(data)
end

def turn_text(game)
  puts game.print_state
  print "Turn #{game.turn} - "
  print display_guess_prompt
  input = gets.chomp
end

puts display_intro
victory_state = game_loop

if victory_state == 'v'
  puts "Congratulations! You won!"
elsif victory_state == 's'
  puts "File saved."
else
  puts "Aww. Better luck next time!"
end

# Save game state if user enters 'save'
# Add ability to load a game state
