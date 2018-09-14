class Character < ActiveRecord::Base
  has_many :inventories
  has_many :characterenvironments
  has_many :shelters
  has_many :environments, through: :characterenvironments
  has_many :environments, through: :shelters

  def self.new_character(name)
    self.create(name: name, thirst: 8, hunger: 8, sleep_stat: 8)
  end

  def create_health
    self.thirst + self.hunger + self.sleep_stat
  end

  def my_stats
    puts "\n"
    puts "Current Character Stats:"
    sleep(0.7)
    puts "\n"
    puts "Health: #{self.health}"
    puts "Thirst: #{self.thirst}"
    puts "Hunger: #{self.hunger}"
    puts "Sleep: #{self.sleep_stat}"
    sleep(0.7)
    puts "\n"
  end

  def collect_wood(current_location)
    if current_location.resource == "wood"
      puts "\n"
      puts "Collecting wood..."
      sleep(1.0)
      puts "\n"
      object = self.inventories.where(name: "wood")
      object[0].increment!(:amount, 5)
    else
      puts "\n"
      puts "You must be in the forest to collect wood!"
      sleep(0.7)
      puts "\n"
    end
  end

  def collect_sand(current_location)
    if current_location.resource == "sand"
      puts "\n"
      puts "Collecting sand..."
      sleep(1.0)
      puts "\n"
      object = self.inventories.where(name: "sand")
      object[0].increment!(:amount, 5)
    else
      puts "\n"
      puts "You must be in the desert to collect sand!"
      sleep(0.7)
      puts "\n"
    end
  end

  def collect_water(current_location)
    if current_location.water == true
      puts "\n"
      puts "Collecting water..."
      sleep(1.0)
      puts "\n"
      object = self.inventories.where(name: "water")
      object[0].increment!(:amount, 5)
    else
      puts "\n"
      puts "You must be in the forest or by the lake to collect water!"
      sleep(0.7)
      puts "\n"
    end
  end

  def collect_stone(current_location)
    if current_location.resource == "stone"
      puts "\n"
      puts "Collecting stone..."
      sleep(1.0)
      puts "\n"
      object = self.inventories.where(name: "stone")
      object[0].increment!(:amount, 5)
    else
      puts "\n"
      puts "You must be in the cave to collect stone!"
      sleep(0.7)
      puts "\n"
    end
  end

  def current_inventory
    wood_object = self.inventories.where(name: "wood")
    wood_count = wood_object[0].amount
    sand_object = self.inventories.where(name: "sand")
    sand_count = sand_object[0].amount
    water_object = self.inventories.where(name: "water")
    water_count = water_object[0].amount
    stone_object = self.inventories.where(name: "stone")
    stone_count = stone_object[0].amount
    food_object = self.inventories.where(name: "food")
    food_count = food_object[0].amount
    puts "\n"
    puts "You currently have the following resources:"
    sleep(0.7)
    puts "\n"
    puts "#{wood_count} wood"
    puts "#{sand_count} sand"
    puts "#{water_count} water"
    puts "#{stone_count} stone"
    puts "#{food_count} food"
    sleep(0.7)
    puts "\n"
  end

  def drink_water
    object = self.inventories.where(name: "water")
    object_count = object[0].amount
    if object_count > 0
      object[0].decrement!(:amount, 1)
      puts "\n"
      puts "drinking water..."
      sleep(1.0)
      puts "\n"
      if self.thirst < 10
        self.increment!(:thirst, 1)
        puts "Your thirst stat is now at #{self.thirst}."
        sleep(0.7)
        puts "\n"
      else
        self.thirst = 10
        puts "Your thirst stat is already maxed out.".colorize(:yellow).blink
        sleep(0.7)
        puts "\n"
      end
      puts "You now have #{object[0].amount} water."
      sleep(0.7)
      puts "\n"
    else
      puts "\n"
      puts "You must collect more water in order to drink!"
      sleep(0.7)
      puts "\n"
    end
    self.update(health: self.create_health)
  end

  def build_shelter(shelter_command, current_location)
    if shelter_command == "wood"
      wood = self.inventories.where(name: "wood")
      wood_count = wood[0].amount
      if wood_count >= 10
        puts "\n"
        puts "Building wood shelter in the #{current_location.name}..."
        sleep(1.0)
        puts "\n"
        Shelter.create(character_id: self.id, environment_id: current_location.id, material: "wood")
        wood[0].decrement!(:amount, 10)
        puts "You now have #{wood[0].amount} wood."
        sleep(0.7)
        puts "\n"
      else
        puts "\n"
        puts "You need 10 wood to build your shelter! You can find more wood in the forest."
        sleep(0.7)
        puts "\n"
      end
    elsif shelter_command == "stone"
      stone = self.inventories.where(name: "stone")
      stone_count = stone[0].amount
      if stone_count >= 15
        puts "\n"
        puts "Building stone shelter in the #{current_location.name}..."
        sleep(1.0)
        puts "\n"
        Shelter.create(character_id: self.id, environment_id: current_location.id, material: "stone")
        stone[0].decrement!(:amount, 15)
        puts "You now have #{stone[0].amount} stone."
        sleep(0.7)
        puts "\n"
      else
        puts "\n"
        puts "You need 15 stones to build your shelter! You can find more stones in the cave."
        sleep(0.7)
        puts "\n"
      end
    end
  end

  def view_my_shelters
   starter_count = self.shelters.where(environment_id: 1).count
   forest_count = self.shelters.where(environment_id: 2).count
   desert_count = self.shelters.where(environment_id: 3).count
   lake_count = self.shelters.where(environment_id: 4).count
   cave_count = self.shelters.where(environment_id: 5).count
   puts "\n"
   puts "You have:"
   sleep(0.7)
   puts "\n"
   puts "#{starter_count} shelter(s) in the Starter Area"
   puts "#{forest_count} shelter(s) in the Forest"
   puts "#{desert_count} shelter(s) in the Desert"
   puts "#{lake_count} shelter(s) by the Lake"
   puts "#{cave_count} shelter(s) in the Cave"
   sleep(0.7)
   puts "\n"
  end

  def go_to_sleep(current_location)
    if current_location.shelters.count > 0
      puts "\n"
      puts "sleeping..."
      sleep(1.0)
      puts "\n"
      if self.sleep_stat < 10
        self.increment!(:sleep_stat, 1)
        puts "Your sleep stat is now at #{self.sleep_stat}."
        sleep(0.7)
        puts "\n"
      else
        self.sleep_stat = 10
        puts "Your sleep stat is already maxed out.".colorize(:yellow).blink
        sleep(0.7)
        puts "\n"
      end
    else
      puts "\n"
      puts "You must build a shelter in this location before you can rest."
      sleep(0.7)
      puts "\n"
    end
    self.update(health: self.create_health)
  end

  def forage_for_food(forage_command, current_location)
    if forage_command == "berries"
      if current_location.food_type == "berries"
        puts "\n"
        puts "Foraging for berries..."
        sleep(1.0)
        puts "\n"
        object = self.inventories.where(name: "food")
        object[0].increment!(:amount, 5)
      else
        puts "\n"
        puts "You must be in the forest to forage for berries!"
        sleep(0.7)
        puts "\n"
      end
    elsif forage_command == "scorpions"
      if current_location.food_type == "scorpions"
        puts "\n"
        puts "Hunting for scorpions..."
        sleep(1.0)
        puts "\n"
        object = self.inventories.where(name: "food")
        object[0].increment!(:amount, 2)
      else
        puts "\n"
        puts "You must be in the desert to hunt scorpions!"
        sleep(0.7)
        puts "\n"
      end
    elsif forage_command == "fish"
      if current_location.food_type == "fish"
        puts "\n"
        puts "Fishing for fish..."
        sleep(1.0)
        puts "\n"
        object = self.inventories.where(name: "food")
        object[0].increment!(:amount, 1)
      else
        puts "\n"
        puts "You must be by the lake to fish!"
        sleep(0.7)
        puts "\n"
      end
    elsif forage_command == "squirrels"
      if current_location.food_type == "squirrels"
        puts "\n"
        puts "Hunting for squirrels..."
        sleep(1.0)
        puts "\n"
        object = self.inventories.where(name: "food")
        object[0].increment!(:amount, 1)
      else
        puts "You must be in the cave to hunt squirrels!"
        sleep(0.7)
        puts "\n"
      end
    end
  end

  def eat_food
    object = self.inventories.where(name: "food")
    object_count = object[0].amount
    if object_count > 0
      object[0].decrement!(:amount, 1)
      puts "eating food..."
      sleep(1.0)
      puts "\n"
      if self.hunger < 10
        self.increment!(:hunger, 1)
        puts "Your hunger stat is now at #{self.hunger}."
        sleep(0.7)
        puts "\n"
      else
        self.hunger = 10
        puts "Your hunger stat is already maxed out.".colorize(:yellow).blink
        sleep(0.7)
        puts "\n"
      end
      puts "You now have #{object[0].amount} food."
      sleep(0.7)
      puts "\n"
    else
      puts "You must look for more food in order to eat!"
      sleep(0.7)
      puts "\n"
    end
    self.update(health: self.create_health)
  end

  def decrease_stats
    array = [false, false, false, false, false, false, false, false, false, false, true]
    array.sample
    if array.sample == true
      if self.thirst > 1
        self.decrement!(:thirst, 2)
        if self.thirst == 2
          puts "Warning! Your thirst stat is down to 2! You must drink more water!".colorize(:yellow).blink
          sleep (0.7)
          puts "\n"
        end
      end
      if self.hunger > 1
        self.decrement!(:hunger, 2)
        if self.hunger == 2
          puts "Warning! Your hunger stat is down to 2! You must eat something!".colorize(:yellow).blink
          sleep(0.7)
          puts "\n"
        end
      end
      if self.sleep_stat > 1
        self.decrement!(:sleep_stat, 2)
        if self.sleep_stat == 2
          puts "Warning! Your sleep stat is down to 2! You must get some rest!".colorize(:yellow).blink
          sleep(0.7)
          puts "\n"
        end
      end
      puts "Oh no! Bad luck! Your thirst, hunger, and sleep stats have decreased!".colorize(:light_red)
      sleep(0.7)
      puts "\n"
    end
    self.update(health: self.create_health)
  end

end
