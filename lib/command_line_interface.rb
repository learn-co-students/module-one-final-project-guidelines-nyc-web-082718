def get_text
  gets.chomp
end

def split_into_words_array(input)
  input_array = input.split(/( \p{P}*)|(\p{P}* )|(\p{P}*\z)| /)
  input_array.delete_if { |s| s == " " }
end

def run_essay_editor
  puts "Welcome! Begin essay editor: please enter your text."
  text_object = Text.new(get_text)

  # ADD WORDS TO DB
  downcased_words_array = text_object.words_array.map { |word| word.downcase }
  add_words_from_array_to_db(downcased_words_array)

  # ESSAY EDITOR WITH TEXT OBJECT
  get_length_and_rand_choice(text_object)
end

def get_length_and_rand_choice(text_object)
  puts "Would you like to LENGTHEN or SHORTEN your essay? (Type l or s)"
  length_option = get_text

  puts "Would you like to CHOOSE each replacement word or have it chosen RANDOMLY? (Type c or r)"
  rand_option = get_text

  if length_option == "l" && rand_option == "c"
    choose_lengthen_essay(text_object)
  elsif length_option == "l" && rand_option == "r"
    rand_lengthen_essay(text_object)
  elsif length_option == "s" && rand_option == "c"
    choose_shorten_essay(text_object)
  elsif length_option == "s" && rand_option == "r"
    rand_shorten_essay(text_object)
  else
    puts "Invalid input!"
    get_length_and_rand_choice(text_object)
  end
end
