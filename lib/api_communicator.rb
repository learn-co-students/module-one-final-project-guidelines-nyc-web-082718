require 'rest-client'
require 'json'
require 'pry'

def get_words_from_api(url)
 #make the web request
 response_string = RestClient.get(url)
 response_hash = JSON.parse(response_string)

end

def welcome
 # welcomes and gives first instruction
 puts "Welcome! Type a word you want to shorten."
end

def get_text
 # chomp the inputted word
 gets.chomp
end

def query(query_type, input)
 # interpolate type and word into url
 # call #get_words_from_api and inputs created url
 # returns an array of words
 url = "https://api.datamuse.com/words?rel_#{query_type}=#{input}"
 get_words_from_api(url)
end

def get_synonyms(input)
 # talk to api and run appropriate queries
 # return array of possible syns
 query("syn", input)
end

def get_antonyms(input)
 # talk to api and run appropriate queries
 # return array of possible ants
 query("ant", input)
end

def get_rhymes(input)
 # talk to api and run appropriate queries
 # return array of possible rhymes
 query("rhy", input)
end

def filter_short_words(arr)
 arr.select { |word| word.length < 6 }
end

def turn_text_to_synonyms
 welcome
 input = get_text.downcase
 input_array = input.split(" ")
 words_with_no_synonyms = []
 output_array = input_array.map do |word|
   if word.length >= 6
     synonyms = get_synonyms(word) # array of syns
     short_words = filter_short_words(synonyms) # array of short syns
     if short_words != []
       word_hash = short_words.sample # single short synonym, as a hash
       new_word = word_hash["word"] # new word as string
     else
       words_with_no_synonyms << word
     end
   end
 end
 puts output_array.join(" ")
 puts "The following words could not be shortened: #{words_with_no_synonyms}"
 binding.pry
end

def turn_text_to_rhymes
 welcome
 input = get_text.downcase
 input_array = input.split(" ")
 words_with_no_rhymes = []
 output_array = input_array.map do |word|
   rhymes = get_rhymes(word) # array of rhymes
   if rhymes != []
     ####################################
     # TO DO:
     # REMOVE FUNCTION WORDS
     # CHECK THAT SYLLABLES ARE THE SAME
     # CHECK THAT PART OF SPEECH IS THE SAME
     ####################################
     word_hash = rhymes.sample # random rhyme
     new_word = word_hash["word"] # new word as string
   else
     words_with_no_rhymes << word
   end
 end
 puts output_array.join(" ")
 puts "The following words had no rhymes: #{words_with_no_synonyms}"
 binding.pry
end

turn_text_to_rhymes


# binding.pry