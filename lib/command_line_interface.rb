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

def fighter_generator
  opponents = []
  5.times do
    fighter = Fighter.fighter_select
    opponents << fighter
  end
  1.times do
    opponents << Fighter.champ_select
  end
  opponents
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
   puts "Choose a number between 1-4"
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
  sleep 2
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
  sleep 2
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
  sleep 1
  puts "Choose your attack! (1-3)"
  puts "1. Punch"
  puts "2. Kick"
  puts "3. Takedown"
  action_capture = []
  action = gets.chomp.to_i

  if action_capture.empty?
    action_capture << action
    action_capture[0]
  end

end

def match_loop(array)
  x = 0
  punch_win = ["Nice punch, one more of those and they'll go down!", "Good contact, next one should knock em out!", "Brutal hammerfist!", "Their face is really taking a beating!", "They must be seeing stars!", "You're a regular Rocky Balboa!"]
  punch_loss = ["I can't believe they blocked that!", "They slipped and countered, be more careful!", "Ouch, they got you good!", "Your eyes are swelling shut!", "If you don't get into the fight, they may have to call it!", "You were knocked down, get back up!"]
  kick_win = ["That knee is looking wobbly, throw another kick!", "Your opponents leg is really swelling up!", "You're really crippling their movement!", "Their leg is buckling!", "Keep up the kicks!", "Your kicks are super effective!"]
  kick_loss =["Throw your hips into it! Your not kicking hard enough!", "They checked your kick, be more careful!", "You slipped and your opponent made you pay for it!", "You through a lazy kick and took a punch to the face for it!", "You're lucky that check didn't break your leg!", "That kick looked like it hurt you more than your opponent!"]
  takedown_win =["Nice takedown, go for the arm bar!", "Nice slam! That'll score you points with the judges!", "Way to keep your opponent off their feet!", "You've got their back! End it!", "Nice! Go for the choke!", "With takedowns like that, your opponent won't be getting off the mat!", "You've landed in full mount, end it!"]
  takedown_loss =["I can't believe they stuffed that!", "They slipped your takedown and countered you with a kick!", "They are defending against the takedown with the fence!", "Get them off the fence! Or stop going for the takedown!", "They reversed your takedown!", "Don't let them get the guillotine!"]
  draw =["These fighters are looking really tired!", "This fight is too close to call!", "How are they still on their feet?", "We've got an exciting fight!", "What an even match!", "Joe Rogan is going to regret missing this one!"]

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
          if com_action == 1
            puts punch_win.sample
            computer_damage += 1
            sleep 1
          elsif com_action == 2
            puts punch_loss.sample
            player_damage += 1
            sleep 1
          else
            puts draw.sample
            sleep 1
          end
        elsif user_action == 2
          if com_action == 2
            puts kick_win.sample
            computer_damage += 1
            sleep 1
          elsif com_action == 1
            puts kick_loss.sample
            player_damage += 1
            sleep 1
          else
            puts draw.sample
            sleep 1
          end
        else
          if com_action == 1
            puts takedown_win.sample
            computer_damage += 1
            sleep 1
          elsif com_action == 2
            puts takedown_loss.sample
            player_damage += 1
            sleep 1
          else
            puts draw.sample
            sleep 1
          end
        end
      end

      if player_damage == 3
        puts "\n" "That was a tough fight, get back in the ring and shake off that loss."
        losses = Player.last.losses
        Player.last.update_column(:losses, losses + 1)
        sleep 2
        x += 1
      elsif computer_damage == 3
        puts "\n" "Congratulations! You defeated #{array[x].name}!!!"
        wins = Player.last.wins
        Player.last.update_column(:wins, wins + 1)
        sleep 2
        x += 1
      else
        puts "something is wrong"
      end
    end #End while loop aka. Each individual fight
    # array logic
  puts "\n" "Congratulations to the new UFC Champion of the world! #{Player.last.name}!!!" "\n" "\n" "**************************************" "\n" "\n" 
end
