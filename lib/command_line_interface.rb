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
  puts "\n""What is your fighter's weight class?"
  if gender == "m"
    puts "(Strawweight, Flyweight, Bantamweight, Lightweight, Super_lightweight, Welterweight, Middleweight, Light_heavyweight or Heavyweight)"
    gets.chomp.downcase
  elsif gender == "f"
    puts "(Strawweight, Flyweight, Bantamweight or Featherweight)"
    gets.chomp.downcase
  else
    puts "Please choose a gender with the format M/F"
  end
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
