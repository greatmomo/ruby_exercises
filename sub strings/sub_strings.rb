def substrings(input_string, dictionary)
  #use reduce to count presence of dictionary words
  input_array = input_string.split(/[^[[:word:]]]+/)
  result_hash = input_array.reduce(Hash.new(0)) do |result, input_word|
    #now for each input word, check the dictionary
    dictionary.each do |dictionary_word|
      #puts "Input: #{input_word}, Dict: #{dictionary_word}"
      if input_word.downcase.include?(dictionary_word)
        result[dictionary_word] += 1
      end
    end
    result
  end
  result_hash.sort_by { |key| key }.to_h
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

#substrings("below", dictionary)

print "Input: Howdy partner, sit down! How's it going?\nDictionary: "
print dictionary
print "\n"
puts substrings("Howdy partner, sit down! How's it going?", dictionary)