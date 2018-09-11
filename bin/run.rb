require 'pry'
require_relative '../config/environment'
require_all 'app'

Environment.create_environments
puts "Welcome to our world! What is your character's name?"
name = gets.chomp
Character.new_character(name)
puts "Hello #{name}! What would you like to do?"
puts "If you don't know what to do, type 'help' to see all possible commands."
gets.chomp
