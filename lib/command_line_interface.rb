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
  puts "\n"
  puts "Here is what you can do:".colorize(:yellow)
  sleep(0.8)
  puts "- help: displays this help message".colorize(:yellow)
  puts "- my stats: allows you to view your current character stats".colorize(:yellow)
  puts "- explore: displays the different areas you can explore".colorize(:yellow)
  puts "- current location: displays where you are currently".colorize(:yellow)
  puts "- build shelter: allows you to build a shelter".colorize(:yellow)
  puts "- my shelters: allows you to view all of your shelters".colorize(:yellow)
  puts "- eat: allows you to eat food and increases your hunger stat".colorize(:yellow)
  puts "- drink: allows you to drink water and increases your thirst stat".colorize(:yellow)
  puts "- sleep: allows you to sleep and increases your sleep stat".colorize(:yellow)
  puts "- collect: allows you to collect a resource and adds it to your inventory".colorize(:yellow)
  puts "- forage: allows you to forage for food and adds it to your inventory".colorize(:yellow)
  puts "- my inventory: allows you to view your inventory".colorize(:yellow)
  puts "- quit: quits this program".colorize(:yellow)
  sleep(1.0)
  puts "\n"
end

def where_to_explore
  puts "\n"
  sleep(0.7)
  puts "Where would you like to go? You can choose between: Forest, Desert, Lake, Cave".colorize(:yellow)
  puts "\n"
end

def what_to_collect
  puts "\n"
  sleep(0.7)
  puts "Which resource would you like to collect? You can choose between: wood, sand, water, stone".colorize(:yellow)
  puts "\n"
end

def shelter_materials
  puts "\n"
  sleep(0.7)
  puts "What would you like to make your shelter out of? You can choose between: wood, stone".colorize(:yellow)
  puts "\n"
end

def what_to_forage
  puts "\n"
  sleep(0.7)
  puts "What food would you like to forage for? You can choose between: berries, scorpions, fish, squirrels".colorize(:yellow)
  puts "\n"
end

def where_am_i(current_location,character)
  if current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 1).environment
    puts "\n"
    sleep(0.7)
    puts "You are currently in the starter area.".colorize(:yellow)
    sleep(0.7)
    puts "\n"
  elsif current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 2).environment
    puts "\n"
    sleep(0.7)
    puts "You are currently in the forest.".colorize(:yellow)
    sleep(0.7)
    puts "\n"
  elsif current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 3).environment
    puts "\n"
    sleep(0.7)
    puts "You are currently in the desert.".colorize(:yellow)
    sleep(0.7)
    puts "\n"
  elsif current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 4).environment
    puts "\n"
    sleep(0.7)
    puts "You are currently by the lake.".colorize(:yellow)
    sleep(0.7)
    puts "\n"
  elsif current_location == CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 5).environment
    puts "\n"
    sleep(0.7)
    puts "You are currently in the cave.".colorize(:yellow)
    sleep(0.7)
    puts "\n"
  end
end

def quit_game
  sleep(0.7)
  puts "\n"
  puts "Thanks for playing!".colorize(:yellow)
  puts "\n"
  sleep(0.8)
end

def run
  a = Artii::Base.new
  puts a.asciify('The Explorer').colorize(:yellow)
  sleep(0.7)
  puts "\n"
  puts "Welcome adventurer! What is your name?".colorize(:yellow)
  puts "\n"
  name = gets.chomp
  character = Character.new_character(name)
  character.update(health: character.create_health)
  Inventory.start_inventory(character.id)
  create_character_environments(character)
  puts "\n"
  sleep(0.7)
  puts "Hello #{name}!".colorize(:yellow)
  sleep(0.7)
  puts "\n"
  puts "\n"
  puts '            _  '.colorize(:yellow).blink
  puts '           (_) '.colorize(:yellow).blink
  puts '           |=| '.colorize(:yellow).blink
  puts '           |=| '.colorize(:yellow).blink
  puts '       /|__|_|__|\ '.colorize(:yellow).blink
  puts '      (    ( )    ) '.colorize(:yellow).blink
  puts '       \|\/\*/\/|/ '.colorize(:yellow).blink
  puts '          | Y | '.colorize(:yellow).blink
  puts '          | | | '.colorize(:yellow).blink
  puts '          | | | '.colorize(:yellow).blink
  puts '         _| | | '.colorize(:yellow).blink
  puts '      __/ | | |\ '.colorize(:yellow).blink
  puts '     /  \ | | |  \ '.colorize(:yellow).blink
  puts '        __| | |   | '.colorize(:yellow).blink
  puts '     /\/  | | |   |\ '.colorize(:yellow).blink
  puts '     <    +\| |\ />  \ '.colorize(:yellow).blink
  puts '       >    +\  LJ    | '.colorize(:yellow).blink
  puts '             + \+  \ < \ '.colorize(:yellow).blink
  puts '      (O)      +    |   ) '.colorize(:yellow).blink
  puts '       |             \  /\ '.colorize(:yellow).blink
  puts '     ( | )    (o)     \/  ) '.colorize(:yellow).blink
  puts '   _\ \|/ /__( | )_____)_/ '.colorize(:yellow).blink
  puts '            \ \|/ / '.colorize(:yellow).blink

  current_location = CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 1).environment

  help

  command = ""
  while command
    puts "What would you like to do?".colorize(:yellow)
    sleep(0.5)
    puts "\n"
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
            puts "\n"
            sleep(0.7)
            puts "You are now in the forest.".colorize(:yellow)
            sleep(0.7)
            puts "\n"
            puts '            ,@@@@@@@,'.colorize(:yellow)
            puts '    ,,,.   ,@@@@@@/@@,  .oo8888o.'.colorize(:yellow)
            puts '  ,&%%&%&&%,@@@@@/@@@@@@,8888\88/8o'.colorize(:yellow)
            puts ',%&\%&&%&&%,@@@\@@@/@@@88\88888/88`'.colorize(:yellow)
            puts '%&&%&%&/%&&%@@\@@/ /@@@88888\88888`'.colorize(:yellow)
            puts '%&&%/ %&%%&&@@\ V /@@ `88\ 8`/88`'.colorize(:yellow)
            puts '`&%\ ` /%&`    |.|        \ `|8'.colorize(:yellow)
            puts '    |o|        | |         | |'.colorize(:yellow)
            puts '    |.|        | |         | |'.colorize(:yellow)
            puts '\ \/ ._\//_/__/  ,\_//_\ \/.  \_//__/_'.colorize(:yellow)
            sleep(0.7)
            puts "\n"
          elsif explore_command == "Desert"
            current_location = CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 3).environment
            puts "\n"
            sleep(0.7)
            puts "You are now in the desert.".colorize(:yellow)
            sleep(0.7)
            puts "\n"
            puts '    .    _    +     .  ______   .          .'.colorize(:yellow)
            puts ' (      /|\      .    |      \      .   +'.colorize(:yellow)
            puts '     . |||||     _    | |   | | ||         .'.colorize(:yellow)
            puts '.      |||||    | |  _| | | | |_||    .'.colorize(:yellow)
            puts '   /\  ||||| .  | | |   | |      |       .'.colorize(:yellow)
            puts '__||||_|||||____| |_|_____________\__________'.colorize(:yellow)
            puts '. |||| |||||  /\   _____      _____  .   .'.colorize(:yellow)
            puts '  |||| ||||| ||||   .   .  .         ________'.colorize(:yellow)
            puts ' . \|`-`|||| ||||    __________       .    . '.colorize(:yellow)
            puts '    \__ |||| ||||      .          .     .'.colorize(:yellow)
            puts ' __    ||||`-`|||  .       .    __________'.colorize(:yellow)
            puts '.    . |||| ___/  ___________             .'.colorize(:yellow)
            puts '   . _ ||||| . _               .   _________'.colorize(:yellow)
            puts '_   ___|||||__  _ \|--|/    .          _'.colorize(:yellow)
            puts '     _ `---`    .)=\oo|=(.   _   .   .    .'.colorize(:yellow)
            puts '_  ^      .  -    . \.|'.colorize(:yellow)
            sleep(0.7)
            puts "\n"
          elsif explore_command == "Lake"
            current_location = CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 4).environment
            puts "\n"
            sleep(0.7)
            puts "You are now by the lake.".colorize(:yellow)
            sleep(0.7)
            puts "\n"
            puts '                                             \ _ /'.colorize(:yellow)
            puts '                                            - (_) -'.colorize(:yellow)
            puts '                                             /   \ '.colorize(:yellow)
            puts '                                       '.colorize(:yellow)
            puts '                                       '.colorize(:yellow)
            puts '                                       '.colorize(:yellow)
            puts '                                       '.colorize(:yellow)
            puts '                                       '.colorize(:yellow)
            puts '                                       '.colorize(:yellow)
            puts '---....______ __ _ _ _____ __ _ ___ ___ __ _ _ _____ _ _ ___'.colorize(:yellow)
            puts '                    `---...___ =-= = -_= -=_= _-=_-_ -=- =-_'.colorize(:yellow)
            puts '                              ```--.._= -_= -_= _-=- -_= _=-'.colorize(:yellow)
            puts '                                      ``--._=-_ =-=_-= _-= _'.colorize(:yellow)
            puts '                                            ``-._=_-=_- =_-='.colorize(:yellow)
            puts '                                                 `-._-=_-_=-'.colorize(:yellow)
            puts '                                                     `-._=-_'.colorize(:yellow)
            puts '                                                         `-.'.colorize(:yellow)
            sleep(0.7)
            puts "\n"
          elsif explore_command == "Cave"
            current_location = CharacterEnvironment.all.find_by(character_id: character.id, environment_id: 5).environment
            puts "\n"
            sleep(0.7)
            puts "You are now in the cave.".colorize(:yellow)
            sleep(0.7)
            puts "\n"
            puts '                     / \ '.colorize(:yellow)
            puts '                    /   \              /`\       _ '.colorize(:yellow)
            puts '\_..           /`.,/     \_         .,`   \     / \_'.colorize(:yellow)
            puts '    \         /            \      _/       \_  /    \     _ '.colorize(:yellow)
            puts '     \__,.   /              \    /           \/.,   _|  _/ \ '.colorize(:yellow)
            puts '          \_/                \  /`,.,/\      \_ \_/  \/    \ '.colorize(:yellow)
            puts '                           _  \/   /    `,../\,.\    _/      \ '.colorize(:yellow)
            puts '             /           _/m\  \  /    |         \  /.,/`\   _\ '.colorize(:yellow)
            puts '           _/           /MMmm\  \_     |          \/      \_/  \  '.colorize(:yellow)
            puts '          /      \     |MMMMmm|   \__   \          \_       \   \_  '.colorize(:yellow)
            puts '                  \   /MMMMMMm|      \   \           \       \    \  '.colorize(:yellow)
            puts '                   \  |MMMMMMmm\      \___            \_      \_   \  '.colorize(:yellow)
            puts '                    \|MMMMMMMMmm|____.`  /\_            \       \   \_ '.colorize(:yellow)
            puts '                    / .,___________...,,`   \            \   \        \ '.colorize(:yellow)
            puts '                   /       \          |      \    |__     \   \_       \ '.colorize(:yellow)
            puts '                 _/        |           \      \_     \     \    \       \_ '.colorize(:yellow)
            puts '                /                               \     \     \_   \        \ '.colorize(:yellow)
            puts '                                                 \     \      \   \__      \ '.colorize(:yellow)
            puts '                                                  \     \_     \     \      \ '.colorize(:yellow)
            puts '                                                   |      \     \     \      \ '.colorize(:yellow)
            puts '                                                    \            |            \ '.colorize(:yellow)
            sleep(0.7)
            puts "\n"
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
        abort(a.asciify("Your character has died.").colorize(:light_red))
      end
    end
end
