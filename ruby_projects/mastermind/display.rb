# frozen_string_literal: true

# Text needed for Mastermind
module Display
  def display_intro
    "Let's play a simple Mastermind game in the console! Try to guess the correct sequence within 12 turns!\n\n"
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

  def display_validity_description
    'Values that are correct and in the correct position will look like: ' + ' ♥ '.on_light_blue + ' and values that are in the wrong position will look like: ' + ' • '.on_light_blue
  end

  def display_validity(validity_array)
    print ' '.on_light_blue + ('♥ ' * validity_array[0]).on_light_blue
    print ('• ' * validity_array[1]).on_light_blue
    print '   '.on_light_blue if validity_array[0] == 0 && validity_array[1] == 0
    puts
  end
end
