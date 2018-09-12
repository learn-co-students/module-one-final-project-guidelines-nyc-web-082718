require 'pry'
require_relative '../config/environment'
require_all 'app'

def introduce_user
  puts "Welcome to our world! What is your character's name?"
  name = gets.chomp
  character = Character.new_character(name)
  Environment.create_environments(character.id)
  Inventory.start_inventory(character.id)
  puts "Hello #{name}! What would you like to do?"
end

character = Character.first

starter_area = Environment.all.where(id: 1)
forest = Environment.all.where(id: 2)
desert = Environment.all.where(id: 3)
lake = Environment.all.where(id: 4)
cave = Environment.all.where(id: 5)

current_location = starter_area

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

def go_to_forest(forest)
  current_location = forest
end

def go_to_desert(desert)
  current_location = desert
end

def go_to_lake(lake)
  current_location = lake
end

def go_to_cave(cave)
  current_location = cave
end

def i_want_wood
  character.collect_wood
end

# binding.pry
