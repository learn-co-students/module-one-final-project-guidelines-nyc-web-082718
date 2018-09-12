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

current_location = Environment.all.where(id: 1)

def first_action
  user_input = gets.chomp
end

def help
  puts "Here is what you can do:"
  puts "- help: displays this help message"
  puts "- explore: displays the different areas you can explore"
  puts "- current location: displays where you are currently"
  puts "- build shelter: allows you to build a shelter"
  puts "- eat: allows you to eat food and increases your hunger stat"
  puts "- drink: allows you to drink water and increases your thirst stat"
  puts "- sleep: allows you to sleep and increases your sleep stat"
  puts "- collect: allows you to collect a resource and adds it to your inventory"
  puts "- my inventory: allows you to view your inventory"
  puts "- quit: quits this program"
end

def where_to_explore
  puts "Where would you like to go? You can choose between: Forest, Desert, Lake, Cave"
end

def what_to_collect
  puts "Which resource would you like to collect? You can choose between: wood, sand, water, stone"
end

def shelter_materials
  puts "What would you like to make your shelter out of? You can choose between: wood, stone"
end

def i_want_wood(current_location, forest)
  Character.first.collect_wood(current_location, forest)
end

def i_want_sand(current_location, desert)
  Character.first.collect_sand(current_location, desert)
end

def i_want_water(current_location, forest, lake)
  Character.first.collect_water(current_location, forest, lake)
end

def i_want_stone(current_location, cave)
  Character.first.collect_water(current_location, forest, lake)
end

def where_am_i(current_location)
  if current_location == Environment.all.where(id: 1)
    puts "You are currently in the starter area."
  elsif current_location == Environment.all.where(id: 2)
    puts "You are currently in the forest."
  elsif current_location == Environment.all.where(id: 3)
    puts "You are currently in the desert."
  elsif current_location == Environment.all.where(id: 4)
    puts "You are currently by the lake."
  elsif current_location == Environment.all.where(id: 5)
    puts "You are currently in the cave."
  end
end


def quit_game
  puts "Thanks for playing!"
end

def run(current_location, starter_area, forest, desert, lake, cave)
  help

  command = ""
  while command
    puts "What would you like to do?"
    command = gets.chomp
    case command
      when "current location"
        where_am_i(current_location, starter_area, forest, desert, lake, cave)
      when "explore"
        where_to_explore
        explore_command = gets.chomp
          if explore_command == "Forest"
            current_location = forest
            puts "You are now in the forest."
          elsif explore_command == "Desert"
            current_location = desert
            puts "You are now in the desert."
          elsif explore_command == "Lake"
            current_location = lake
            puts "You are now by the lake."
          elsif explore_command == "Cave"
            current_location = cave
            puts "You are now in the cave."
          end
      when "build shelter"
        shelter_materials
        shelter_command = gets.chomp
        Character.first.build_shelter(shelter_command, current_location)
      when "eat"
        puts "eating..."
      when "drink"
        Character.first.drink_water
      when "sleep"
        puts "sleeping..."
      when "collect"
        what_to_collect
        collect_command = gets.chomp
        if collect_command == "wood"
          i_want_wood(current_location, forest)
        elsif collect_command == "sand"
          i_want_sand(current_location, desert)
        elsif collect_command == "water"
          i_want_water(current_location, forest, lake)
        elsif collect_command == "stone"
          i_want_stone(current_location, cave)
        end
      when "my inventory"
        Character.first.current_inventory
      when "quit"
        quit_game
        break
      else
        help
      end
    end
end

binding.pry
