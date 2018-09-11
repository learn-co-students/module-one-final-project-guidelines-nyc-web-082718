require_relative '../config/environment'



puts "Welcome to our world! What is your character's name?"
name = gets.chomp
new_character(name)
puts "Hello #{name}! What would you like to do?"
