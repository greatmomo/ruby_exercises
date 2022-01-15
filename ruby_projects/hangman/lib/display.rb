# frozen_string_literal: true

# Text needed for Hangman
module Display
  def display_intro
    "Let's play a simple Hangman game in the console! Try to guess the correct word within 8 turns!\n\n"
  end

  def display_guess_prompt
    "Enter your next guess, or type 'save' to save your progress: "
  end

  def display_filename_prompt
    'Enter the filename: '
  end

  def display_game_prompt
    'Enter 1 to play a new game. Enter 2 to load a saved game.'
  end
end

include Display
