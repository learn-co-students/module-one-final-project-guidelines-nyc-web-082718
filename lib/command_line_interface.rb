require 'pry'
require 'rest-client'
require 'json'
require 'active_record'
require_relative '../app/models/player'


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
 weight_class?
 gender == "m" ? male_weight_classes : female_weight_classes
 num = gets.chomp.to_i
   if gender == "m"
     weight_class= m_hash[num]
   else
     weight_class = f_hash[num]
   end
   sleep 1
 thats_tough
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
end

 def move
   moves
 end

def match_loop(array)
  x = 0
  while x < 6
    if Player.last.losses < 3 && x < 5
      Fight.create(user_id: Player.last.id, fighter_id: array[0][x].id)
        player_damage = 0
        computer_damage = 0
        match_announcement(array[0][x].name)

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
              player_damage += 1
              computer_damage += 1
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
              player_damage += 1
              computer_damage += 1
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
              player_damage += 1
              computer_damage += 1
              sleep 1
            end
          end
        end

      player_damage == 3 ? take_loss_script(array[0][x].name) : take_win_script(array[0][x].name)
      x += 1

    elsif Player.last.losses < 3 && x == 5
      Fight.create(user_id: Player.last.id, fighter_id: array[0][x].id)
      championship_announcement(array[0][x].name)
      player_damage = 0
      computer_damage = 0
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

      if player_damage == 3
        championship_loss_script
        x += 1
      else computer_damage == 3
        player_wins
        x += 1
      end

    else
      game_over_before_championship
      return
    end ##End if statement
  end #End while loop aka. Each individual fight
    # array logic
end
