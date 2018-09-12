require 'rest-client'
require 'json'
require 'pry'



def get_words_from_api(url)
 #make the web request
 response_string = RestClient.get(url)
 response_hash = JSON.parse(response_string)
end

# def split_into_words_array(text_string)
#   input = text_string.downcase
#   input_array = input.split(" ")
#
#   puts input_array
# end

def make_word_object_from_api(word)
  query_types = ["syn", "ant", "rhy"]
  #loop through query types, populate all of word's attributes
  query_types.each do |type|
    # get api for syn or ant or rhy
    query(query_type, word)
    # populate database
  end
end


def save_all_words_in_word_array_to_db(words_array)
  words_array.each do |word_object|
     if word_object_short?(word_object)
       #########################
       # TO DO: figure out how to get each of the following
       word = word_object["word"]
       length = word.length
       # syllables =
       ##########################
       ShortWord.new(word: word, length: length) #, syllables: syllables)
     else
       LongWord.new(word: word, length: length)# , syllables: syllables)
     end
   end
end

def query(query_type, input)
 url = "https://api.datamuse.com/words?rel_#{query_type}=#{input}&md=spd"
 words_array = get_words_from_api(url)

 #save to DB depending on length
 save_all_words_in_word_array_to_db(words_array)

 words_array
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

# def filter_short_words(arr)
#  arr.select { |word| word.length < 6 }
# end

def word_object_short?(word_object)
  word_object["word"].length < 6
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
 # binding.pry
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

# turn_text_to_rhymes


# binding.pry
