# frozen_string_literal: true

# Text needed for Mastermind
module Display
  def display_intro
    "Let's play a simple Mastermind game in the console! \n\n"
  end

  def display_mode_select
    "Press '1' to the the SETTER or '2' to be the GUESSER:"
  end

  def display_winner(winner)
    "GAME OVER! #{winner} is the winner!"
  end

  def display_board_creation
    'To build your code, enter four numbers 1-6 and press enter:'
  end

  def display_guess_prompt
    'To make a guess, enter four numbers 1-6 and press enter:'
  end
end
