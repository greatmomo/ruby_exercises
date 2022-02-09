def caesar_cipher(input_string, shift)
  chars = input_string.split('')
  # puts "Original: #{input_string}"

  #puts chars
  chars.map! do |char|
    ascii = char.ord
    if ascii >= 65 && ascii <= 90
      #uppercase stuff
      offset = ascii + shift
      if offset >= 90
        ascii = 64 + (offset - 90)
      else
        ascii = offset
      end
    elsif ascii >= 97 && ascii <= 122
      #lowercase stuff
      offset = ascii + shift
      if offset >= 122
        ascii = 96 + (offset - 122)
      else
        ascii = offset
      end
    else
      #keep value
    end
    ascii.chr
  end

  # print "Cipher: #{chars.join('')}\n"
  chars.join('')

  #puts "a: #{'a'.ord}, z: #{'z'.ord}, A: #{'A'.ord}, Z: #{'Z'.ord}"
end

caesar_cipher("What a string!", 5)
