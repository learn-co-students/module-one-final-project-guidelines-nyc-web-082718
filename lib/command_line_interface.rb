require 'pry'
require 'rest-client'
require 'json'
require 'active_record'
require_relative '../app/models/player'

def welcome
  puts "\n""Welcome to the UFC!"
end

def get_gender
    puts "What is your fighter's gender? (M/F)"
    gets.chomp.downcase
end

def get_weight_class(gender)
 m_hash = {1=> "Strawweight", 2=> "Bantamweight", 3=> "Lightweight", 4=> "Welterweight", 5=> "Middleweight", 6=> "Light_heavyweight", 7=> "Heavyweight"}

 f_hash = {1=> "Women_Strawweight", 2=> "Women_Flyweight", 3=> "Women_Bantamweight", 4=> "Women_Featherweight"}

 puts "\n""What is your fighter's weight class?"
 if gender == "m"
   puts "Choose a number between 1-7"
   puts "1. Strawweight"
   puts "2. Bantamweight"
   puts "3. Lightweight"
   puts '4. Welterweight'
   puts "5. Middleweight"
   puts "6. Light Heavyweight"
   puts "7. Heavyweight"
   weight_class= m_hash[gets.chomp.to_i]
 elsif gender == "f"
   puts "1. Strawweight"
   puts "2. Flyweight"
   puts "3. Bantamweight"
   puts "4. Featherweight"
   weight_class = f_hash[gets.chomp.to_i]
 else
   puts "Please choose a gender with the format M/F"
 end
 puts "That weight class is one of the toughest! Good luck!"
 weight_class
end

def get_name
  puts "\n""What is your fighter's name?"
  gets.chomp.downcase
end

def format_name(name)
  upper_name = name.split(" ").map do |name|
    name.capitalize
  end
  formatted_name = upper_name.join(" ")
  formatted_name
end

def get_nickname(formatted_name)
  puts "\n""You're almost ready to fight #{formatted_name}, what is your nickname?"
  gets.chomp.downcase
end

def format_nickname(nickname)
  upper_name = nickname.split(" ").map do |name|
    name.capitalize
  end
  formatted_nickname = upper_name.join(" ")
  formatted_nickname
end

def complete_player_creation(formatted_name, formatted_nickname, gender, weight_class)
  full_name_array = formatted_name.split(" ")
  full_name = full_name_array.insert(1, formatted_nickname).join(" ")

  format_weight_class = weight_class.split("_").map do |class_name|
    class_name.capitalize
  end
  formatted_weight_class = format_weight_class.join(" ")

  Player.create(name: full_name, gender: gender, weightclass: weight_class, wins: 0, losses: 0)

  puts "\n""It's time!!! #{full_name} enters the UFC as a promising rookie #{formatted_weight_class}!"
end

def match_announcement(fighter_name)
  puts "\n""You've been matched against #{fighter_name}"
  sleep 1
  puts "\n""Ladies and Gentlemen! #{Player.last.name} vs. #{fighter_name}!"
  sleep 1
  puts "3"
  sleep 1
  puts "2"
  sleep 1
  puts "1"
  sleep 1
  puts "Fight!"
  sleep 1
end

def championship_announcement(fighter_name)
  puts "\n""You've been matched against the reigning champion of the world #{fighter_name}!!"
  sleep 1
  puts "\n""Ladies and Gentlemen! #{Player.last.name} vs. #{fighter_name}!"
  sleep 1
  puts "3"
  sleep 1
  puts "2"
  sleep 1
  puts "1"
  sleep 1
  puts "Fight!"
  sleep 1
end

def moves
  puts "Press a number to go for a move"
  puts "1. Punch"
  puts "2. Kick"
  puts "3. Takedown"
  action = gets.chomp.to_i
  action
end




def match_loop(array)
  x = 0
  punch_win = ["Nice punch, one more of those and they'll go down!", "Good contact, next one should knock em out"]
  punch_loss = ["I can't believe they blocked that!", "They slipped and countered, be more careful!"]
  kick_win = ["That knee is looking wobbly, throw another kick!"]
  kick_loss =["Throw your hips into it! Your not kicking hard enough!", "They shielded and countered, be more careful!"]
  takedown_win =["Nice takedown, go for the arm bar!", " Nice takedown! That'll score with the judges!"]
  takedown_loss =["I can't believe they blocked that!", "They slipped and countered, be more careful!"]

  while x < 6
    Fight.create(user_id: Player.last.id, fighter_id: array[x].id)
      player_damage = 0
      computer_damage = 0
       x == 5 ? championship_announcement(array[x].name) :  match_announcement(array[x].name)


      while player_damage < 3 && computer_damage < 3
        puts "\n"
        user_action = moves
        com_action = rand(3)
        puts "\n"
        if user_action == 1
          if com_action == 1 || 2
            puts punch_win.sample
            computer_damage += 1
          else
            puts punch_loss.sample
            player_damage += 1
          end
        elsif user_action == 2
          if com_action == 2 || 1
            puts kick_win.sample
            computer_damage += 1
          else
            puts kick_loss.sample
            player_damage += 1
          end
        else
          if com_action == 1
            puts takedown_win.sample
            computer_damage += 1
          else com_action == 2 ||3
            puts takedown_loss.sample
            player_damage += 1
          end
        end
      end

      if player_damage == 3
        puts "\n" "That was a tough fight, are you feeling okay? Better luck next time."
        losses = Player.last.losses
        Player.last.update_column(:losses, losses + 1)
        sleep 2
        x += 1
      elsif computer_damage == 3
        puts "\n" "Congratulations! You defeated #{array[x].name}"
        wins = Player.last.wins
        Player.last.update_column(:wins, wins + 1)
        sleep 2
        x += 1
      else
        puts "something is wrong"
      end
    end #End while loop aka. Each individual fight
    # array logic
  puts "\n" "Congratulations to the new UFC Champion of the world! #{Player.last.name}!!!!!!!!!" "\n" "**********************************************************"
end
