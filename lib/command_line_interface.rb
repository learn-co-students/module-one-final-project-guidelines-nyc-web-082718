require 'pry'
require_relative '../config/environment'
require_all 'app'


def create_character_environments(character)
  CharacterEnvironment.create(character_id: character.id, environment_id: 1)
  CharacterEnvironment.create(character_id: character.id, environment_id: 2)
  CharacterEnvironment.create(character_id: character.id, environment_id: 3)
  CharacterEnvironment.create(character_id: character.id, environment_id: 4)
  CharacterEnvironment.create(character_id: character.id, environment_id: 5)
end

def help
  sleep(1.0)
  puts "Here is what you can do:"
  sleep(0.7)
  puts "- help: displays this help message"
  puts "- my stats: allows you to view your current character stats"
  puts "- explore: displays the different areas you can explore"
  puts "- current location: displays where you are currently"
  puts "- build shelter: allows you to build a shelter"
  puts "- my shelters: allows you to view all of your shelters"
  puts "- eat: allows you to eat food and increases your hunger stat"
  puts "- drink: allows you to drink water and increases your thirst stat"
  puts "- sleep: allows you to sleep and increases your sleep stat"
  puts "- collect: allows you to collect a resource and adds it to your inventory"
  puts "- forage: allows you to forage for food and adds it to your inventory"
  puts "- my inventory: allows you to view your inventory"
  puts "- quit: quits this program"
  sleep(0.8)
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

def what_to_forage
  puts "What food would you like to forage for? You can choose between: berries, scorpions, fish, squirrels"
end

def where_am_i(current_location,character)
  if current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 1).environment
    puts "You are currently in the starter area."
  elsif current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 2).environment
    puts "You are currently in the forest."
  elsif current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 3).environment
    puts "You are currently in the desert."
  elsif current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 4).environment
    puts "You are currently by the lake."
  elsif current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 5).environment
    puts "You are currently in the cave."
  end
end

def quit_game
  puts "Thanks for playing!"
  sleep(0.7)
end

def run

  puts "Welcome to our world! What is your character's name?"
  name = gets.chomp
  character = Character.new_character(name)
  character.update(health: character.create_health)
  Inventory.start_inventory(character.id)
  create_character_environments(character)
  puts "Hello #{name}!"

  current_location = CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 1).environment

  help



  command = ""
  while command
    puts "What would you like to do?"
    command = gets.chomp
    character.decrease_stats
    case command
      when "my stats"
        character.my_stats
      when "current location"
        where_am_i(current_location, character)
      when "explore"
        where_to_explore
        explore_command = gets.chomp
        character.decrease_stats
          if explore_command == "Forest"
            current_location = CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 2).environment
            puts "You are now in the forest."
          elsif explore_command == "Desert"
            current_location = CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 3).environment
            puts "You are now in the desert."
          elsif explore_command == "Lake"
            current_location = CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 4).environment
            puts "You are now by the lake."
          elsif explore_command == "Cave"
            current_location = CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 5).environment
            puts "You are now in the cave."
          end
      when "build shelter"
        shelter_materials
        shelter_command = gets.chomp
        character.decrease_stats
        character.build_shelter(shelter_command, current_location)
      when "my shelters"
        character.view_my_shelters
      when "eat"
        character.eat_food
      when "drink"
        character.drink_water
      when "sleep"
        character.go_to_sleep(current_location)
      when "collect"
        what_to_collect
        collect_command = gets.chomp
        character.decrease_stats
        if collect_command == "wood"
          character.collect_wood(current_location)
        elsif collect_command == "sand"
          character.collect_sand(current_location)
        elsif collect_command == "water"
          character.collect_water(current_location)
        elsif collect_command == "stone"
          character.collect_stone(current_location)
        end
      when "forage"
        what_to_forage
        forage_command = gets.chomp
        character.decrease_stats
        character.forage_for_food(forage_command, current_location)
      when "my inventory"
        character.current_inventory
      when "quit"
        quit_game
        break
      else
        help
      end
      unless character.health > 0
        abort("Your character has died. Thanks for playing!")
      end
    end
end

#binding.pry
