def get_text
  gets.chomp
end

def split_into_words_array(input)
  input_array = input.split(/( \p{P}*)|(\p{P}* )|(\p{P}*\z)| /)
end

def run_essay_editor
  puts "Welcome! Begin essay editor: please enter your text."
  input = get_text

  words_array = split_into_words_array(input)
  downcased_words_array = words_array.map { |word| word.downcase }

  add_words_from_array_to_db(downcased_words_array)
  get_length_and_rand_choice(words_array)
end

def get_length_and_rand_choice(words_array)
  puts "Would you like to LENGTHEN or SHORTEN your essay? (Type l or s)"
  length_option = get_text

  puts "Would you like to CHOOSE each replacement word or have it chosen RANDOMLY? (Type c or r)"
  rand_option = get_text

  if length_option == "l" && rand_option == "c"
    choose_lengthen_essay(words_array)
  elsif length_option == "l" && rand_option == "r"
    rand_lengthen_essay(words_array)
  elsif length_option == "s" && rand_option == "c"
    choose_shorten_essay(words_array)
  elsif length_option == "s" && rand_option == "r"
    rand_shorten_essay(words_array)
  else
    puts "Invalid input!"
    get_length_and_rand_choice(words_array)
  end
end

def rand_lengthen_essay(words_array)
  unlengthened_words = []

  new_words_array = words_array.map do |word|
    if short_string?(word)
      # do something
      short_word_object = ShortWord.find_by(word: word.downcase)
      wordlinks_list = WordLink.where(short_word: short_word_object)
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
  ### change word

            cap(wordlinks_list.sample.long_word.word)
          else
  ### change word

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
  ### change word

            if cap?(word)
              cap(matching_pos_list.sample.long_word.word)
            else
  ### change word

              matching_pos_list.sample.long_word.word
            end
          end
        end
      end
    else
      word
    end
  end

  new_text = new_words_array.join
  puts new_text
  if !unlengthened_words.empty?
    unlengthened_words_cleaned = unlengthened_words.select { |w| /[A-Za-z]+/.match(w) }
    puts "We were unable to lengthen the following words:"
    puts unlengthened_words_cleaned.join(", ")
  end
end

def choose_lengthen_essay(words_array)
  unlengthened_words = []

  new_words_array = words_array.map do |word|
    if short_string?(word)
      # do something
      short_word_object = ShortWord.find_by(word: word.downcase)
      wordlinks_list = WordLink.where(short_word: short_word_object)
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
  ### change word
            puts "Choose a word to replace #{word}:"
            puts "0) Do not replace"
            wordlinks_list.each_with_index do |wl, i|
              puts "#{i+1}) #{wl.long_word.word}"
            end # end wordlinks_list.each_with_index do |wl, i|
            choice = get_text.to_i - 1
            if choice == -1
              word
            else
              cap(wordlinks_list[choice].long_word.word)
            end
          else
  ### change word
            puts "Choose a word to replace #{word}:"
            puts "0) Do not replace"
            wordlinks_list.each_with_index do |wl, i|
              puts "#{i+1}) #{wl.long_word.word}"
            end # end wordlinks_list.each_with_index do |wl, i|
            choice = get_text.to_i - 1
            if choice == -1
              word
            else
              wordlinks_list[choice].long_word.word
            end
          end # if cap?(word)
        else
          # multiple parts of speech
          puts "Which of the following describes '#{word}': #{tags_array.join(", ")}?"
          part_of_speech = get_text
          matching_pos_list = wordlinks_list.select do |word_link_object|
            # find words whose part of speech matches
            word_link_object.long_word.tags.include? part_of_speech
          end # end matching_pos_list = wordlinks_list.select do
          if matching_pos_list.empty?
            unlengthened_words << word
            word
          else
            if cap?(word)
  ### change word
              puts "Choose a word to replace #{word}:"
              puts "0) Do not replace"
              matching_pos_list.each_with_index do |wl, i|
                puts "#{i+1}) #{wl.long_word.word}"
              end # matching_pos_list.each_with_index do |wl, i|
              choice = get_text.to_i - 1
              if choice == -1
                word
              else
                cap(matching_pos_list[choice].long_word.word)
              end
            else
  ### change word
              puts "Choose a word to replace #{word}:"
              puts "0) Do not replace"
              matching_pos_list.each_with_index do |wl, i|
                puts "#{i+1}) #{wl.long_word.word}"
              end #
              choice = get_text.to_i - 1
              if choice == -1
                word
              else
                matching_pos_list[choice].long_word.word
              end
            end # if cap?(word)
          end # if matching_pos_list.empty?
        end # end if tags_array.length <= 1
      end # end if wordlinks_list.empty?
    else
      word
    end # end if short_string?(word)
  end # end new_words_array = words_array.map do |word|

  new_text = new_words_array.join
  puts new_text
  if !unlengthened_words.empty?
    unlengthened_words_cleaned = unlengthened_words.select { |w| /[A-Za-z]+/.match(w) }
    puts "We were unable to lengthen the following words:"
    puts unlengthened_words_cleaned.join(", ")
  end # end if !unlengthened_words.empty?
end # end choose_lengthen_essay method

def rand_shorten_essay(words_array)
  unshortened_words = []

  new_words_array = words_array.map do |word|
    if !short_string?(word)
      # do something
      long_word_object = LongWord.find_by(word: word.downcase)
      wordlinks_list = WordLink.where(long_word: long_word_object)
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
  ### change word

            cap(wordlinks_list.sample.short_word.word)
          else
  ### change word

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
  ### change word
              cap(matching_pos_list.sample.short_word.word)
            else
  ### change word
              matching_pos_list.sample.short_word.word
            end
          end
        end
      end
    else
      word
    end
  end

  new_text = new_words_array.join
  puts new_text
  if !unshortened_words.empty?
    unshortened_words_cleaned = unshortened_words.select { |w| /[A-Za-z]+/.match(w) }
    puts "We were unable to shorten the following words:"
    puts unshortened_words_cleaned.join(", ")
  end
end

# def choose_shorten_essay(words_array)
#   unshortened_words = []
#
#   new_words_array = words_array.map do |word|
#     if !short_string?(word)
#       # do something
#       long_word_object = LongWord.find_by(word: word.downcase)
#       wordlinks_list = WordLink.where(long_word: long_word_object)
#       if wordlinks_list.empty?
#         unshortened_words << word
#         # do not switch word
#         word
#       else
#         tags_array = arrayify_string(long_word_object.tags)
#         # switch word - check if multiple parts of speech
#         if tags_array.length <= 1
#           # only one part of speech
#           if cap?(word)
# ### change word
#             puts "Choose a word to replace #{word}:"
#             puts "0) Do not replace"
#             wordlinks_list.each_with_index do |wl, i|
#               puts "#{i+1}) #{wl.short_word.word}"
#             end
#             choice = get_text.to_i - 1
#             if choice == -1
#               word
#             else
#               cap(wordlinks_list[choice].short_word.word)
#             end
#           else
# ### change word
#             puts "Choose a word to replace #{word}:"
#             puts "0) Do not replace"
#
#             wordlinks_list.each_with_index do |wl, i|
#               puts "#{i+1}) #{wl.short_word.word}"
#             end
#             choice = get_text.to_i - 1
#             if choice == -1
#               word
#             else
#               wordlinks_list[choice].short_word.word
#             end
#           end
#         else
#           # multiple parts of speech
#           puts "Which of the following describes '#{word}': #{tags_array.join(", ")}?"
#           part_of_speech = get_text
#           matching_pos_list = wordlinks_list.select do |word_link_object|
#             # find words whose part of speech matches
#             word_link_object.short_word.tags.include? part_of_speech
#           end
#           if matching_pos_list.empty?
#             unshortened_words << word
#             word
#           else
#             if cap?(word)
#   ### change word
#               puts "Choose a word to replace #{word}:"            puts "0) Do not replace"
#
#               matching_pos_list.each_with_index do |wl, i|
#                 puts "#{i+1}) #{wl.short_word.word}"
#               end
#               choice = get_text.to_i - 1
#               if choice == -1
#                 word
#               else
#                 cap(matching_pos_list[choice].short_word.word)
#               end
#             else
#   ### change word
#               puts "Choose a word to replace #{word}:"            puts "0) Do not replace"
#               matching_pos_list.each_with_index do |wl, i|
#                 puts "#{i+1}) #{wl.short_word.word}"
#               end
#               choice = get_text.to_i - 1
#               if choice == -1
#                 word
#               else
#                 matching_pos_list[choice].short_word.word
#               end
#             end
#           end
#         end
#       end
#     else
#       word
#     end
#   end
#
#   new_text = new_words_array.join
#   puts new_text
#   if !unshortened_words.empty?
#     unshortened_words_cleaned = unshortened_words.select { |w| /[A-Za-z]+/.match(w) }
#     puts "We were unable to shorten the following words:"
#     puts unshortened_words_cleaned.join(", ")
#   end
# end

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
