#!/usr/bin/env ruby
require 'rest-client'

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
input = get_text
split_into_words_array(input)
