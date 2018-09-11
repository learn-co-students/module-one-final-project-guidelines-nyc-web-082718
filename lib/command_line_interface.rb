require 'pry'
require_relative '../config/environment'
require_all 'app'

Environment.create_environments
def introduce_user
  puts "Welcome to our world! What is your character's name?"
  name = gets.chomp
  Character.new_character(name)
  puts "Hello #{name}! What would you like to do?"
  help_reminder
end

def first_action
  user_input = gets.chomp
end

def help_reminder
  puts "If you don't know what to do, type 'help' to see all possible commands."
end

def help
  puts "Here is what you can do:"
  puts "- help: displays this help message"
  puts "- build shelter: allows you to build a shelter"
  puts "- explore: displays the different areas you can explore"
  puts "- eat: allows you to eat food and increases your hunger stat"
  puts "- drink: allows you to drink water and increases your thirst stat"
  puts "- sleep: allows you to sleep and increases your sleep stat"
  puts "- collect: allows you to collect a resource and adds it to your inventory"
end
