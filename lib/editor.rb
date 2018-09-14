def choose_lengthen_essay(text_object)
  new_text_object = text_object.map_text_lengthen
  puts new_text_object.text
  text_object.print_unlengthened_words
end

def rand_lengthen_essay(text_object)
  new_text_object = text_object.map_text_lengthen_rand
  puts new_text_object.text
  text_object.print_unlengthened_words
end

def choose_shorten_essay(text_object)
  new_text_object = text_object.map_text_shorten
  puts new_text_object.text
  text_object.print_unshortened_words
end

def rand_shorten_essay(text_object)
  new_text_object = text_object.map_text_shorten_rand
  puts new_text_object.text
  text_object.print_unshortened_words
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

######################
