require 'rest-client'
require 'json'
require 'pry'

def add_words_from_array_to_db(words_array)
  words_array.each do |word_string|
    add_word_and_related_words_to_db(word_string)
  end
end

#### RUN METHOD ###
def add_word_and_related_words_to_db(word_string)

  original_word_hash = get_info_hash(word_string)
  original_word = add_word_to_db(original_word_hash)       #part 1
  new_word = add_related_words_to_db(word_string)   #part 2

  # make wordlink if orig/new are diff            #part 3
end


#### PART 1 ####

def get_info_hash(word_string)
  # binding.pry
  sl_array = query("info", word_string)
  word_hash = sl_array[0]
  turn_original_hash_into_info_hash(word_hash)
end

def add_word_to_db(word_hash)
  if short?(word_hash)
    word = ShortWord.create(word_hash)
  else
    word = LongWord.create(word_hash)
  end
  word
end

# def add_word_to_db(word_string)
#   word_hash = get_info_hash(word_string)
#   if short?(word_hash)
#     word = ShortWord.create(word_hash)
#   else
#     word = LongWord.create(word_hash)
#   end
#   word
# end

  ## Part 1 - Child Methods ##

  def short?(word_hash)
    word_hash["length"] < 6
  end

#### PART 2 ####

def add_related_words_to_db(word_string)
  query_types = ["synonym", "antonym", "rhyme"]
  related_words_hash = {}

  query_types.each do |type|
    word_objects_array = query(type, word_string)
    related_words_hash[type] = word_objects_array
  end

  # related_words_hash will look like:
      # {"synonym": [{w}{w}{w}...],
      # "antonym": [{word}{word}...],
      # "rhyme": [{word}{word}...]}

  related_words_hash.each do |type, word_objects_array|
    # word_objects_array looks like:
        # [{word}{word}...]
    word_objects_array.each do |word_object|
      # word_object looks like:
      # { word: "sad", score: 3, numSyllables: 1,.....}
      info_hash = turn_original_hash_into_info_hash(word_object)
        # info_hash looks like:
        # { word: "sad", numSyllables: 1,.....}
      add_word_to_db(info_hash)
    end
  end
end

  ## Part 2 - Child Methods ##

  def query(query_type, input)

    # binding.pry
    param = case query_type
    when "info"
      "sl"
    when "synonym"
      "rel_syn"
    when "antonym"
      "rel_ant"
    when "rhyme"
      "rel_rhy"
    end

    # url = "https://api.datamuse.com/words?#{param}=#{input}&md=spd"
    url = "https://api.datamuse.com/words?#{param}=#{input}&md=sp"
    words_array = get_words_from_api(url)
  end

  def turn_original_hash_into_info_hash(word_hash)
    word_hash.delete("score")
    word_hash["length"] = word_hash["word"].length
    word_hash
  end


















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
#
#
# def save_all_words_in_word_array_to_db(words_array)
#   words_array.each do |word_object|
#      if word_object_short?(word_object)
#        #########################
#        # TO DO: figure out how to get each of the following
#        word = word_object["word"]
#        length = word.length
#        # syllables =
#        ##########################
#        ShortWord.new(word: word, length: length) #, syllables: syllables)
#      else
#        LongWord.new(word: word, length: length)# , syllables: syllables)
#      end
#    end
# end
#
# def turn_text_to_synonyms
#  welcome
#  input = get_text.downcase
#  input_array = input.split(" ")
#  words_with_no_synonyms = []
#  output_array = input_array.map do |word|
#    if word.length >= 6
#      synonyms = get_synonyms(word) # array of syns
#      short_words = filter_short_words(synonyms) # array of short syns
#      if short_words != []
#        word_hash = short_words.sample # single short synonym, as a hash
#        new_word = word_hash["word"] # new word as string
#      else
#        words_with_no_synonyms << word
#      end
#    end
#  end
#  puts output_array.join(" ")
#  puts "The following words could not be shortened: #{words_with_no_synonyms}"
#  # binding.pry
# end
#
# def turn_text_to_rhymes
#  welcome
#  input = get_text.downcase
#  input_array = input.split(" ")
#  words_with_no_rhymes = []
#  output_array = input_array.map do |word|
#    rhymes = get_rhymes(word) # array of rhymes
#    if rhymes != []
#      ####################################
#      # TO DO:
#      # REMOVE FUNCTION WORDS
#      # CHECK THAT SYLLABLES ARE THE SAME
#      # CHECK THAT PART OF SPEECH IS THE SAME
#      ####################################
#      word_hash = rhymes.sample # random rhyme
#      new_word = word_hash["word"] # new word as string
#    else
#      words_with_no_rhymes << word
#    end
#  end
#  puts output_array.join(" ")
#  puts "The following words had no rhymes: #{words_with_no_synonyms}"
#  # binding.pry
# end

# turn_text_to_rhymes


# binding.pry
