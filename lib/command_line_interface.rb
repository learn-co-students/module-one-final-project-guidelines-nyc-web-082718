def welcome
 # welcomes and gives first instruction
 puts "Welcome!"
end

def essay_or_rhyme
  puts "Would you like to edit an essay or spit some rhymes? (Type E or R)"
  if get_text == "e"
    run_essay_editor
  elsif get_text == "r"
    run_rhymer
  else
    puts "Invalid input!"
    essay_or_rhyme
  end
end

def get_text
  gets.chomp.downcase
end

def split_into_words_array(input)
  input_array = input.split(" ")
end

#################### essay editor

def run_essay_editor
  puts "Begin essay editor: please enter your text."
  input = get_text
  words_array = split_into_words_array(input)
  add_words_from_array_to_db(words_array)
  lengthen_or_shorten(words_array)
end

def lengthen_or_shorten(words_array)
  puts "Would you like to lengthen or shorten your essay? (Type L or S)"
  length_option = get_text
  if length_option == "l"
    lengthen_essay(words_array)
  elsif length_option == "s"
    shorten_essay(words_array)
  else
    puts "Invalid input!"
    lengthen_or_shorten(words_array)
  end
end

def lengthen_essay(words_array)
  unlengthened_words = []

  new_words_array = words_array.map do |word|
    if short_string?(word)
      # do something
      short_word_object = ShortWord.find_by(word: word)
      wordlinks_list = WordLink.where(short_word: short_word_object, link_type: "synonym")
      # binding.pry
      if wordlinks_list.empty?
        unlengthened_words << word
        word
      else
        wordlinks_list.sample.long_word.word
      end
    else
      word
    end
  end
  new_text = new_words_array.join(" ")
  puts new_text
  puts "We were unable to lengthen the following words:"
  puts unlengthened_words.join(", ")
end

def shorten_essay(words_array)
  unshortened_words = []

  new_words_array = words_array.map do |word|
    if !short_string?(word)
      # do something
      long_word_object = LongWord.find_by(word: word)
      wordlinks_list = WordLink.where(long_word: long_word_object, link_type: "synonym")
      # binding.pry
      if wordlinks_list.empty?
        unshortened_words << word
        word
      else
        wordlinks_list.sample.short_word.word
      end
    else
      word
    end
  end
  new_text = new_words_array.join(" ")
  puts new_text
  puts "We were unable to shorten the following words:"
  puts unshortened_words.join(", ")
end

################### rhymer

# def run_rhymer
#   ask_for_text
# end
