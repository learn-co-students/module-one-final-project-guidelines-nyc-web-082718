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
# part 1 ################################################
  original_word_hash = get_info_hash(word_string)
  original_word = find_or_add_word_to_db(original_word_hash)       #part 1
# part 2 ################################################
  add_related_words_to_db(word_string)   #part 2


end


#### PART 1 ####

def get_info_hash(word_string)


  sl_array = query("info", word_string)
  word_hash = sl_array[0]
  turn_original_hash_into_info_hash(word_hash)
end

def find_or_add_word_to_db(word_hash)
  word = word_hash[:word]
  if ShortWord.find_by(word: word)
    ShortWord.find_by(word: word)
  elsif LongWord.find_by(word: word)
    LongWord.find_by(word: word)
  else
    word_object = nil
    if short_hash?(word_hash)
      word_object = ShortWord.create(word_hash)
    else
      word_object = LongWord.create(word_hash)
    end
    word_object
  end
end

# def find_or_add_word_to_db(word_string)
#   word_hash = get_info_hash(word_string)
#   if short_hash?(word_hash)
#     word = ShortWord.create(word_hash)
#   else
#     word = LongWord.create(word_hash)
#   end
#   word
# end

  ## Part 1 - Child Methods ##

  def short_hash?(word_hash)
    word_hash["length"] < 6
  end

#### PART 2 ####

def add_related_words_to_db(word_string)
  original_word = nil
  if short_string?(word_string)
    original_word = ShortWord.find_by(word: word_string)
  else
    original_word = LongWord.find_by(word: word_string)
  end




  query_types = ["rhyme", "synonym", "antonym"]
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
    word_objects_array.each do |word_hash|
      new_word = word_hash[:word]
      # word_hash looks like:
      # { word: "sad", score: 3, numSyllables: 1,.....}

      # add words to db/create ShortWord/LongWords
      info_hash = turn_original_hash_into_info_hash(word_hash)
        # info_hash looks like:
        # { word: "sad", numSyllables: 1,.....}
      new_word_object = find_or_add_word_to_db(info_hash)
        # either a ShortWord or a LongWord

      # create WordLink for each word if length is opposite of original word
      # binding.pry
      if original_word.class != new_word_object.class
        if original_word.class == ShortWord
          WordLink.create(short_word: original_word, long_word: new_word_object, link_type: type)
        elsif original_word.class == LongWord
          WordLink.create(short_word: new_word_object, long_word: original_word, link_type: type)
        end
      end
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

  def short_string?(word_string)
    word_string.length < 6
  end


















def get_words_from_api(url)
 #make the web request
 # binding.pry
 response_string = RestClient.get(url)
 # binding.pry
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
