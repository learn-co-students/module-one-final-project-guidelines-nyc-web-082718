require 'pry'
require_relative '../config/environment'
require_all 'app'

def introduce_user
  puts "Welcome to our world! What is your character's name?"
  name = gets.chomp
  character = Character.new_character(name)
  Environment.create_environment(character.id)
  Inventory.start_inventory(character.id)
  puts "Hello #{name}! What would you like to do?"
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

def go_to_forest
  Environment.first.update(name: "Forest", water: true, resource: "wood")
end

def go_to_desert
  Environment.first.update(name: "Desert", water: false, resource: "sand")
end

def go_to_lake
  Environment.first.update(name: "Lake", water: true, resource: "water")
end

def go_to_cave
  Environment.first.update(name: "Cave", water: false, resource: "stone")
end

def i_want_wood
  Character.first.collect_wood
end

binding.pry
