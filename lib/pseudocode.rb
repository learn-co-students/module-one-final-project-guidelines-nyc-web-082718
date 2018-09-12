# def get_text
#   gets.chomp
#   # => "bad man"
# end

# def split_into_words_array(get_text)
#   # => ["bad", "man"]
# end

def add_words_from_array_to_db(words_array)
  words_array.each do |word_string|
    add_word_and_related_words_to_db(word_string)
  end
end

#### RUN METHOD ###

def add_word_and_related_words_to_db(word_string)

  original_word = add_word_to_db(word_string) #part 1
  new_word = add_related_words_to_db(word_string)  #part 2
  # make wordlink if orig/new are diff #part 3
end

#### PART 1 ####

def add_word_to_db(word_string)
  word_hash = get_info_hash(word_string)
  if short?(word_hash)
    word = ShortWord.create(word_hash)
  else
    word = LongWord.create(word_hash)
  end
  word
end

    ## Part 1 - Child Methods ##

    def get_info_hash(word_string)
      sl_array = query("info", word_string)
      word_hash = sl_array[0]
      turn_original_hash_into_info_hash(word_hash)
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
        add_word_to_db(info)
      end
  end

    ## Part 2 - Child Methods ##

    def query(query_type, input)
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

      url = "https://api.datamuse.com/words?#{param}=#{input}&md=spd"
      words_array = get_words_from_api(url)
    end

    def turn_original_hash_into_info_hash(word_hash)
      word_hash.delete("score")
      word_hash["length"] = word_hash["word"].length
      word_hash
    end

def get_related_word_info_hash(related_word_object)
  word_hash = related_word_object
  turn_original_hash_into_info_hash(word_hash)
end

def turn_original_hash_into_info_hash(word_hash)
  word_hash.delete("score")
  word_hash["length"] = word_hash["word"].length
  word_hash
end

def short?(word_hash)
  word_hash["length"] < 6
end

def length_of_object(word_object)
  if word_object.class == ShortWord
    "short"
  elsif word_object.class == LongWord
    "long"
  end
end

    PART 2(word) # get synonyms, rhymes, antonyms

        related_words_hash.each do |type, word_objects_array|
            word_objects_array.each do |word_object|
method: make_word_instance_from_string
            get_info_hash(word_string)                    ####### factor
                => info_hash
            create_word_instance(info_hash)
                if short, do:
                    => new_word = ShortWord.new(info_hash)
                    => new_word_class = "short"
                if long, do:
                    => new_word = LongWord.new(info_hash)
                    => new_word_class = "long"            ######### factor

                # for words that are Longwords, do WordLink.new(shortword/longword)
                if original_word.class != new_word.class
                    WordLink.new(original_word_class: original_word, new_word_class: new_word)
                end
            end

        end


PART 1. call ?sl; the first word object will be bad - get info on "bad" and add it to :shortwords
query(?sl, word)[0] to get word object with attributes
  # write method to get attributes from word object - it should return a hash that looks like:
  METHOD NAME:

  ARGUMENT:
  word string
  DESIRED OUTPUT:
  info_hash = {
    word: "bad",
    length: 3,
    part_of_speech: "adj",
    num_syllables: 1,
    definitions: [
                  "very intense",
                  "not financially safe or secure",
                  "nonstandard"...
                  ]
  }

#################
# TO DO:
# make methods to split up words with multiple parts of speech into multiple ShortWord or LongWord objects
#################

Is word long or short?
Create either LongWord or ShortWord with following attributes:
ShortWord.new(info_hash)
    - word
    - length(part of word itself)
    - part of speech
    - # of syllables
    - definition

PART 2. Call a) syn b) ant c) rhy and get 3 arrays of related words
query_types.each do |type|
    query(type, word) to get an ARRAY of related word objects with attributes
    Is word long or short?

For each new word, use the info to add to either :shortwords or :longwords
    Create either LongWord or ShortWord with following attributes:
        - word
        - length(part of word itself)
        - part of speech
        - # of syllables
        - definition

If ORIGINAL WORD ("bad") is short and new word is long, also create a WordLink joining the two.
    Is original word length opposite of new word length?
    If so, create WordLink with attributes:
        - ShortWord
        - LongWord
