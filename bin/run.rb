#!/usr/bin/env ruby
require 'rest-client'
require 'active_record'

db = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')


require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"
require_relative "../lib/editor.rb"

require_relative "../app/models/long_word.rb"
require_relative "../app/models/short_word.rb"
require_relative "../app/models/word_link.rb"
require_relative "../app/models/text.rb"

run_essay_editor

# A mote it is to trouble the mind's eye. In the most high and palmy state of Rome, A little ere the mightiest Julius fell, The graves stood tenantless and the sheeted dead Did squeak and gibber in the Roman streets As stars with trains of fire and dews of blood, Disasters in the sun, and the moist star Upon whose influence Neptune's empire stands Was sick almost to doomsday with eclipse. And even the like precurse of feared events, As harbingers preceding still the fates And prologue to the omen coming on, Have heaven and earth together demonstrated Unto our climatures and countrymen.
