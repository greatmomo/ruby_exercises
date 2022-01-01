# frozen_string_literal: true

# rubocop: disable Layout/LineLength

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
end
# rubocop:enable Layout/LineLength