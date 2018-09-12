def welcome
 # welcomes and gives first instruction
 puts "Welcome! Input text to be analyzed"
end

def get_text
 # chomp the inputted word
 gets.chomp.downcase
end

def split_into_words_array(input)
  input_array = input.split(" ")
end
