

def game_over_before_championship
  puts "\n" "Hey, I'm Dana White. You've lost your contract with the UFC. You lost too many times. Better luck next time #{Player.last.name}" "\n" "\n" "**************************************" "\n" "\n"
  return
end

def player_wins
  puts "\n" "Congratulations to the new UFC Champion of the world! #{Player.last.name}!!!" "\n" "\n" "**************************************" "\n" "\n"
end


def punch_win
  ["Nice punch, one more of those and they'll go down!", "Good contact, next one should knock em out!", "Brutal hammerfist!", "Their face is really taking a beating!", "They must be seeing stars!", "You're a regular Rocky Balboa!"]
end


def punch_loss
  ["I can't believe they blocked that!", "They slipped and countered, be more careful!", "Ouch, they got you good!", "Your eyes are swelling shut!", "If you don't get into the fight, they may have to call it!", "You were knocked down, get back up!"]
end

def kick_win
   ["That knee is looking wobbly, throw another kick!", "Your opponents leg is really swelling up!", "You're really crippling their movement!", "Their leg is buckling!", "Keep up the kicks!", "Your kicks are super effective!"]
end

def kick_loss
  ["Throw your hips into it! Your not kicking hard enough!", "They checked your kick, be more careful!", "You slipped and your opponent made you pay for it!", "You threw a lazy kick and took a punch to the face for it!", "You're lucky that check didn't break your leg!", "That kick looked like it hurt you more than your opponent!"]
end

def takedown_win
["Nice takedown, go for the arm bar!", "Nice slam! That'll score you points with the judges!", "Way to keep your opponent off their feet!", "You've got their back! End it!", "Nice! Go for the choke!", "With takedowns like that, your opponent won't be getting off the mat!", "You've landed in full mount, end it!"]
end

def takedown_loss
["I can't believe they stuffed that!", "They slipped your takedown and countered you with a kick!", "They are defending against the takedown with the fence!", "Get them off the fence! Or stop going for the takedown!", "They reversed your takedown!", "Don't let them get the guillotine!"]
end

def draw
["These fighters are looking really tired!", "This fight is too close to call!", "How are they still on their feet?", "We've got an exciting fight!", "What an even match!", "Joe Rogan is going to regret missing this one!"]
end




def welcome
  puts "\n""Welcome to the UFC!"
  sleep 1
  puts "\n" "Choose your difficulty" "\n"
  puts "Enter a number between 1- 4"
  puts "1. Rookie"
  puts "2. Rising Star"
  puts "3. Veteran"
  puts "4. Legend"
  difficulty = gets.chomp.to_i
  difficulty
end


def enter_the_ufc_script(difficulty)
   Player.last.gender == "m" ? pronoun = "he" : pronoun = "she"
   Player.last.gender == "m" ? pronoun2 = "his" : pronoun2 = "her"

  scripts = {
    1 => "#{Player.last.name} enters the UFC as a promising young rookie. Let's see if #{pronoun} can take this league by storm.",

    2 => "#{Player.last.name} enters the UFC as an up and coming brawler. I wonder if #{pronoun} can continue #{pronoun2} success.",

    3 => "#{Player.last.name} is back at it. We know what #{pronoun} is capable of already. But #{pronoun} has some tough opponents to face.",

    4 => "#{Player.last.name} is back! The one and the only!"
  }
  sleep 1
  puts "\n"  "#{scripts[difficulty]}"  "\n"
  sleep 1

end


def take_loss_script(name)
  puts "\n" "That was a tough fight, #{name} is a good fighter, get back in the ring and shake off that loss."
  losses = Player.last.losses
  Player.last.update_column(:losses, losses + 1)
  sleep 2
end

def take_win_script(name)
  puts "\n" "You defeated #{name}!!!"
  wins = Player.last.wins
  Player.last.update_column(:wins, wins + 1)
  sleep 2
end

def championship_loss_script
  puts "\n" "That championship fight was wild ladies and gentleman!!! We go to the judges score cards. #{champion_name} is still your reigning champion! Better luck next time #{Player.last.name}"  "\n"
end
