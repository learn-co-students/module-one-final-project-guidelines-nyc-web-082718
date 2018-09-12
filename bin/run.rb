#!/usr/bin/env ruby
require 'rest-client'

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
film_or_character
#
# character = get_character_from_user
# show_character_movies(character)
