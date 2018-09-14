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
  original_word = find_or_add_word_to_db(original_word_hash)
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
  word = word_hash["word"]
  #  first check if exists already
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

################ PART 2


def add_related_words_to_db(word_string)
  original_word = nil
  if short_string?(word_string)
    original_word = ShortWord.find_by(word: word_string)
  else
    original_word = LongWord.find_by(word: word_string)
  end

  word_objects_array = query("synonym", word_string)
    # word_objects_array looks like:
        # [{word}{word}...]
  words_without_spaces_array = word_objects_array.delete_if do |word_hash|
    (word_hash["word"].include? " ") || (word_hash["tags"] == nil)
  end

  words_without_spaces_array.each do |word_hash|
    new_word = word_hash["word"]
    # word_hash looks like:
    # { word: "sad", score: 3, numSyllables: 1,.....}

    # add words to db/create ShortWord/LongWords
    info_hash = turn_original_hash_into_info_hash(word_hash)
      # info_hash looks like:
      # { word: "sad", numSyllables: 1,.....}
    new_word_object = find_or_add_word_to_db(info_hash)
      # either a ShortWord or a LongWord

    # create WordLink for each word if length is opposite of original word
    #
    if original_word.class != new_word_object.class
      if original_word.class == ShortWord && !WordLink.find_by(short_word: original_word, long_word: new_word_object)
        WordLink.create(short_word: original_word, long_word: new_word_object)
      elsif original_word.class == LongWord && !WordLink.find_by(short_word: new_word_object, long_word: original_word)
        WordLink.create(short_word: new_word_object, long_word: original_word)
      end
    end
  end


end

def query(query_type, input)
  param = case query_type
  when "info"
    "sl"
  when "synonym"
    "rel_syn"
  end

  url = "https://api.datamuse.com/words?#{param}=#{input}&md=p"
  words_array = get_words_from_api(url)
end

def get_words_from_api(url)
 response_string = RestClient.get(url)
 response_hash = JSON.parse(response_string)
end

def turn_original_hash_into_info_hash(word_hash)
  word_hash.delete("score")
  word_hash["length"] = word_hash["word"].length
  word_hash
end

def short_string?(word_string)
  word_string.length < 6
end

def short_hash?(word_hash)
  word_hash["length"] < 6
end
