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

  Player.create(name: full_name, gender: gender, weightclass: weight_class)

  puts "\n""It's time!!! #{full_name} enters the UFC as a promising rookie #{formatted_weight_class}!"
end

# binding.pry
