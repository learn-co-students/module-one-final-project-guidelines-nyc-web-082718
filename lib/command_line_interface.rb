def welcome
  puts "welcome i hate star wars"
end

def film_or_character

  puts "Do you want to know about a film or a character?"
  answer = gets.chomp.downcase
  case answer
  when "film"
    film = get_film_from_user
    show_film_info(film)
  when "character"
    character = get_character_from_user
    show_character_movies(character)
  else
    puts "Invalid input"
    welcome
  end
end

def get_film_from_user
  puts "please enter a film"
  gets.chomp.downcase
end

def get_character_from_user
  puts "please enter a character"
  gets.chomp.downcase
end
