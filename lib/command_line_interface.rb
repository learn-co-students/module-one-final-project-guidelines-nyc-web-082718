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
  puts "- explore: displays the different areas you can explore"
  puts "- build shelter: allows you to build a shelter"
  puts "- eat: allows you to eat food and increases your hunger stat"
  puts "- drink: allows you to drink water and increases your thirst stat"
  puts "- sleep: allows you to sleep and increases your sleep stat"
  puts "- collect: allows you to collect a resource and adds it to your inventory"
  puts "- quit : quits this program"
end

def where_to_explore
 puts "Where would you like to go? You can choose between: Forest, Desert, Lake, Cave"
end

def go_to_forest(current_location, forest)
  current_location = forest
end

def go_to_desert(current_location, desert)
  current_location = desert
end

def go_to_lake(current_location, lake)
  current_location = lake
end

def go_to_cave(current_location, cave)
  current_location = cave
end

def i_want_wood
  character.collect_wood
end

def quit_game
  puts "Thanks for playing!"
end

def run
  help

  while command
    puts "What would you like to do?"
    command = gets.chomp
    case command
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
        puts "building shelter..."
      when "eat"
        puts "eating..."
      when "drink"
        puts "drinking water..."
      when "sleep"
        puts "sleeping..."
      when "collect"
        puts "collecting resources..."
      when "quit"
        quit_game
        break
      else
        help
      end
    end
end

#binding.pry
