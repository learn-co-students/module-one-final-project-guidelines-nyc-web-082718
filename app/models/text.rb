class Text

  attr_accessor :text, :unlengthened_words, :unshortened_words, :words_array, :current_word

  def initialize(text="")
    @text = text
    @unlengthened_words = []
    @unshortened_words = []
    @words_array = split_into_words_array(text)

    @current_word
  end

  def map_text_lengthen_rand
    new_text_object = Text.new(self.text)

    new_words_array = self.words_array.map do |word|
      self.current_word = word

      # SHORT - Y
      if short_string?(word)
        short_word_object = ShortWord.find_by(word: word.downcase)
        wordlinks_list = WordLink.where(short_word: short_word_object)

        # SYNONYMS - N
        if wordlinks_list.empty?
          unlengthened_words << word
          word

        # SYNONYMS - Y
        else
          tags_array = arrayify_string(short_word_object.tags)

          # MULTIPLE POS - Y
          if tags_array.length <= 1

            # CAP - Y
            if cap?(word)
              cap(wordlinks_list.sample.long_word.word)

            # CAP - N
            else
              wordlinks_list.sample.long_word.word
            end # if cap?(word)

          # MULTIPLE POS - N
          else
            puts "Which of the following describes '#{word}': #{tags_array.join(", ")}?"
            part_of_speech = get_text
            matching_pos_list = wordlinks_list.select do |word_link_object|
              # find words whose part of speech matches
              tags_array = arrayify_string(word_link_object.long_word.tags)
              tags_array.include? part_of_speech
            end # end matching_pos_list = wordlinks_list.select do

            # SYNONYMS - N
            if matching_pos_list.empty?
              unlengthened_words << word
              word

            # SYNONYMS - Y
            else

              # CAP - Y
              if cap?(word)
                cap(matching_pos_list.sample.long_word.word)

              # CAP - N
              else
                matching_pos_list.sample.long_word.word

              end # if cap?(word)
            end # if matching_pos_list.empty?
          end # end if tags_array.length <= 1
        end # end if wordlinks_list.empty?

      # SHORT - N
      else
        word
      end # end if short_string?(word)
    end # end new_words_array = words_array.map do |word|

    new_text_object.text = new_words_array.join(" ")
    new_text_object
  end

  def map_text_lengthen
    new_text_object = Text.new(self.text)

    new_words_array = self.words_array.map do |word|
      self.current_word = word

      # SHORT - Y
      if short_string?(word)
        short_word_object = ShortWord.find_by(word: word.downcase)
        wordlinks_list = WordLink.where(short_word: short_word_object)

        # SYNONYMS - N
        if wordlinks_list.empty?
          unlengthened_words << word
          word

        # SYNONYMS - Y
        else
          tags_array = arrayify_string(short_word_object.tags)

          # MULTIPLE POS - Y
          if tags_array.length <= 1

            # CAP - Y
            if cap?(word)
              get_long_word_choice(wordlinks_list, true)

            # CAP - N
            else
              get_long_word_choice(wordlinks_list, false)
            end # if cap?(word)

          # MULTIPLE POS - N
          else
            puts "Which of the following describes '#{word}': #{tags_array.join(", ")}?"
            part_of_speech = get_text
            matching_pos_list = wordlinks_list.select do |word_link_object|
              # find words whose part of speech matches
              tags_array = arrayify_string(word_link_object.long_word.tags)
              tags_array.include? part_of_speech
            end # end matching_pos_list = wordlinks_list.select do

            # SYNONYMS - N
            if matching_pos_list.empty?
              unlengthened_words << word
              word

            # SYNONYMS - Y
            else

              # CAP - Y
              if cap?(word)
                get_long_word_choice(matching_pos_list, true)

              # CAP - N
              else
                get_long_word_choice(matching_pos_list, false)

              end # if cap?(word)
            end # if matching_pos_list.empty?
          end # end if tags_array.length <= 1
        end # end if wordlinks_list.empty?

      # SHORT - N
      else
        word
      end # end if short_string?(word)
    end # end new_words_array = words_array.map do |word|

    new_text_object.text = new_words_array.join(" ")
    new_text_object
  end

  def map_text_shorten_rand
    new_text_object = Text.new(self.text)

    new_words_array = self.words_array.map do |word|
      self.current_word = word

      # SHORT - N
      if !short_string?(word)
        long_word_object = LongWord.find_by(word: word.downcase)
        wordlinks_list = WordLink.where(long_word: long_word_object)

        # SYNONYMS - N
        if wordlinks_list.empty?
          unshortened_words << word
          word

        # SYNONYMS - Y
        else
          tags_array = arrayify_string(long_word_object.tags)

          # MULTIPLE POS - Y
          if tags_array.length <= 1

            # CAP - Y
            if cap?(word)
              cap(wordlinks_list.sample.short_word.word)

            # CAP - N
            else
              wordlinks_list.sample.short_word.word
            end # if cap?(word)

          # MULTIPLE POS - N
          else
            puts "Which of the following describes '#{word}': #{tags_array.join(", ")}?"
            part_of_speech = get_text
            matching_pos_list = wordlinks_list.select do |word_link_object|
              # find words whose part of speech matches
              tags_array = arrayify_string(word_link_object.short_word.tags)
              tags_array.include? part_of_speech
            end # end matching_pos_list = wordlinks_list.select do

            # SYNONYMS - N
            if matching_pos_list.empty?
              unshortened_words << word
              word

            # SYNONYMS - Y
            else

              # CAP - Y
              if cap?(word)
                cap(matching_pos_list.sample.short_word.word)

              # CAP - N
              else
                matching_pos_list.sample.short_word.word

              end # if cap?(word)
            end # if matching_pos_list.empty?
          end # end if tags_array.length <= 1
        end # end if wordlinks_list.empty?

      # SHORT - N
      else
        word
      end # end if short_string?(word)
    end # end new_words_array = words_array.map do |word|

    new_text_object.text = new_words_array.join(" ")
    new_text_object
  end

  def map_text_shorten
    new_text_object = Text.new(self.text)

    new_words_array = self.words_array.map do |word|
      self.current_word = word

      # SHORT - N
      if !short_string?(word)
        long_word_object = LongWord.find_by(word: word.downcase)
        wordlinks_list = WordLink.where(long_word: long_word_object)

        # SYNONYMS - N
        if wordlinks_list.empty?
          unshortened_words << word
          word

        # SYNONYMS - Y
        else
          tags_array = arrayify_string(long_word_object.tags)

          # MULTIPLE POS - Y
          if tags_array.length <= 1
            # CAP - Y
            if cap?(word)
              get_short_word_choice(wordlinks_list, true)

            # CAP - N
            else
              get_short_word_choice(wordlinks_list, false)
            end # if cap?(word)

          # MULTIPLE POS - N
          else
            puts "Which of the following describes '#{word}': #{tags_array.join(", ")}?"
            part_of_speech = get_text
            matching_pos_list = wordlinks_list.select do |word_link_object|
              # find words whose part of speech matches
              tags_array = arrayify_string(word_link_object.short_word.tags)
              tags_array.include? part_of_speech
            end # end matching_pos_list = wordlinks_list.select do

            # SYNONYMS - N
            if matching_pos_list.empty?
              unshortened_words << word
              word

            # SYNONYMS - Y
            else

              # CAP - Y
              if cap?(word)
                get_short_word_choice(matching_pos_list, true)

              # CAP - N
              else
                get_short_word_choice(matching_pos_list, false)

              end # if cap?(word)
            end # if matching_pos_list.empty?
          end # end if tags_array.length <= 1
        end # end if wordlinks_list.empty?

      # SHORT - Y
      else
        word
      end # end if short_string?(word)
    end # end new_words_array = words_array.map do |word|

    new_text_object.text = new_words_array.join(" ")
    new_text_object
  end

#############################


  def get_long_word_choice(list_to_choose_from, cap=false)
    puts "Type the number of the word you'd like to replace '#{self.current_word}':"
    puts "0) Do not replace"
    list_to_choose_from.each_with_index do |wl, i|
      puts "#{i+1}) #{wl.long_word.word}"
    end
    input = get_text
    if !((/^[0-9]*$/.match(input)) && (0..list_to_choose_from.length).include?(input.to_i))
      puts "Invalid input!"
      get_long_word_choice(list_to_choose_from, cap)
    else
      choice = input.to_i - 1
      if choice == -1
        self.current_word
      else
        if cap == true
          cap(list_to_choose_from[choice].long_word.word)
        elsif cap == false
          list_to_choose_from[choice].long_word.word
        end
      end
    end
  end

  def get_short_word_choice(list_to_choose_from, cap=false)
    puts "Type the number of the word you'd like to replace '#{self.current_word}':"
    puts "0) Do not replace"
    list_to_choose_from.each_with_index do |wl, i|
      puts "#{i+1}) #{wl.short_word.word}"
    end
    input = get_text
    if !((/^[0-9]*$/.match(input)) && (0..list_to_choose_from.length).include?(input.to_i))
      puts "Invalid input!"
      get_short_word_choice(list_to_choose_from, cap)
    else
      choice = input.to_i - 1
      if choice == -1
        self.current_word
      else
        if cap == true
          cap(list_to_choose_from[choice].short_word.word)
        elsif cap == false
          list_to_choose_from[choice].short_word.word
        end
      end
    end
  end

  def print_unlengthened_words
    unlengthened_words_cleaned = self.unlengthened_words.select { |w| /[A-Za-z]+/.match(w) }
    if !unlengthened_words_cleaned.empty?
      puts "We were unable to lengthen the following words:"
      puts unlengthened_words_cleaned.join(", ")
    end
  end

  def print_unshortened_words
    unshortened_words_cleaned = self.unshortened_words.select { |w| /[A-Za-z]+/.match(w) }
    if !unshortened_words_cleaned.empty?
      puts "We were unable to lengthen the following words:"
      puts unshortened_words_cleaned.join(", ")
    end
  end

end
