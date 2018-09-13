#!/usr/bin/env ruby
require 'rest-client'
require 'active_record'


db = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')



require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"
require_relative "../app/models/long_word.rb"
require_relative "../app/models/short_word.rb"
require_relative "../app/models/word_link.rb"

welcome
input = get_text
# no argument => string
words_array = split_into_words_array(input)
# string => array of word strings
add_words_from_array_to_db(words_array)
# array of word strings => no return value;
# pushes each word AND related words into database
    # (add_word_and_related_words_to_db)
# binding.pry
