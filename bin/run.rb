#!/usr/bin/env ruby
require 'rest-client'
require 'active_record'

db = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')


require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"
require_relative "../app/models/long_word.rb"
require_relative "../app/models/short_word.rb"
require_relative "../app/models/word_link.rb"

run_essay_editor
