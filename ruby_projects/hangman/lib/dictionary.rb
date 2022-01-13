# frozen_string_literal: true

# Dictionary class reads valid data from file
class Dictionary
  def random_word
    dictionary = []

    File.open('dictionary.txt', 'r').readlines.each do |line|
      dictionary.push(line.strip) if line.strip.length >= 5 && line.strip.length <= 12
    end

    dictionary[rand(0...dictionary.length)].upcase
  end
end
