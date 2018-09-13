def welcome
 # welcomes and gives first instruction
 puts "Welcome!"
end

def essay_or_rhyme
  puts "Would you like to edit an essay or spit some rhymes? (Type e or r)"
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
  gets.chomp # .downcase
end

def split_into_words_array(input)
  # input_array = input.split(" ")
  input_array = input.split(/( \p{P}*)|(\p{P}* )|(\p{P}*\z)| /)
end

#################### essay editor

def run_essay_editor
  puts "Begin essay editor: please enter your text."
  input = get_text
  words_array = split_into_words_array(input)
  downcased_words_array = words_array.map { |word| word.downcase }

  add_words_from_array_to_db(downcased_words_array, "synonym")
  lengthen_or_shorten(words_array)
end

def lengthen_or_shorten(words_array)
  puts "Would you like to lengthen or shorten your essay? (Type l or s)"
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
      short_word_object = ShortWord.find_by(word: word.downcase)
      wordlinks_list = WordLink.where(short_word: short_word_object, link_type: "synonym")
      if wordlinks_list.empty?
        unlengthened_words << word
        # do not switch word
        word
      else
        tags_array = arrayify_string(short_word_object.tags)
        # switch word - check if multiple parts of speech
        if tags_array.length <= 1
          # only one part of speech
          if cap?(word)
            cap(wordlinks_list.sample.long_word.word)
          else
            wordlinks_list.sample.long_word.word
          end
        else
          # multiple parts of speech
          puts "Which of the following describes '#{word}': #{tags_array.join(", ")}?"
          part_of_speech = get_text
          matching_pos_list = wordlinks_list.select do |word_link_object|
            # find words whose part of speech matches
            word_link_object.long_word.tags.include? part_of_speech
          end
          if matching_pos_list.empty?
            unlengthened_words << word
            word
          else
            if cap?(word)
              cap(matching_pos_list.sample.long_word.word)
            else
              matching_pos_list.sample.long_word.word
            end
          end
        end
      end
    else
      word
    end
  end

  # new_words_array_cleaned = new_words_array.delete_if { |word| word == "" || word == " " }
  #

  new_text = new_words_array.join
  puts new_text
  if !unlengthened_words.empty?
    unlengthened_words_cleaned = unlengthened_words.select { |w| /[A-Za-z]+/.match(w) }
    puts "We were unable to lengthen the following words:"
    puts unlengthened_words_cleaned.join(", ")
  end
end

# write shorten essay dfn!!!


def shorten_essay(words_array)
  unshortened_words = []

  new_words_array = words_array.map do |word|
    if !short_string?(word)
      # do something
      long_word_object = LongWord.find_by(word: word.downcase)
      wordlinks_list = WordLink.where(long_word: long_word_object, link_type: "synonym")
      if wordlinks_list.empty?
        unshortened_words << word
        # do not switch word
        word
      else
        tags_array = arrayify_string(long_word_object.tags)
        # switch word - check if multiple parts of speech
        if tags_array.length <= 1
          # only one part of speech
          if cap?(word)
            cap(wordlinks_list.sample.short_word.word)
          else
            wordlinks_list.sample.short_word.word
          end
        else
          # multiple parts of speech
          puts "Which of the following describes '#{word}': #{tags_array.join(", ")}?"
          part_of_speech = get_text
          matching_pos_list = wordlinks_list.select do |word_link_object|
            # find words whose part of speech matches
            word_link_object.short_word.tags.include? part_of_speech
          end
          if matching_pos_list.empty?
            unshortened_words << word
            word
          else
            if cap?(word)
              cap(matching_pos_list.sample.short_word.word)
            else
              matching_pos_list.sample.short_word.word
            end
          end
        end
      end
    else
      word
    end
  end

  # new_words_array_cleaned = new_words_array.delete_if { |word| word == "" || word == " " }
  #

  new_text = new_words_array.join
  puts new_text
  if !unshortened_words.empty?
    unshortened_words_cleaned = unshortened_words.select { |w| /[A-Za-z]+/.match(w) }
    puts "We were unable to shorten the following words:"
    puts unshortened_words_cleaned.join(", ")
  end
end


def arrayify_string(string)
  string_without_brackets = string.sub("[\"", "").sub("\"]", "")
  array = string_without_brackets.split("\", \"")
end

def cap?(word_string)
  word_string[0].upcase == word_string[0]
end

def cap(word_string)
  first_letter = word_string[0].upcase
  rest = word_string[1..-1]
  first_letter + rest
end


################### rhymer

# def run_rhymer
#   ask_for_text
# end
