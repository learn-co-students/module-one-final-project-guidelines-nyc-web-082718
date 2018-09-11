def welcome
  puts "Welcome to the UFC!"
end


def get_gender
    puts "What is your fighter's gender? (M/F)"
    gets.chomp.downcase
end

def get_weight_class(gender)
  puts "What is your fighter's weight class?"
  if gender == "m"
    puts "Strawweight, Flyweight, Bantamweight, Lightweight, Super_lightweight, Welterweight, Middleweight, Light_heavyweight or Heavyweight"
    gets.chomp.downcase
  elsif gender == "f"
    puts "Strawweight, Flyweight, Bantamweight or Featherweight"
    gets.chomp.downcase
  else
    puts "Please choose a gender with the format M/F"
  end
end

def get_name
  puts "What is your fighter's name?"
  gets.chomp.downcase
end

def get_nickname
  puts "Right on [HELPER METHOD] , what is your fighter nickname? "
  gets.chomp.downcase
end
