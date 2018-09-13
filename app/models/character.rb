class Character < ActiveRecord::Base
  has_many :inventories
  has_many :characterenvironments
  has_many :shelters
  has_many :environments, through: :characterenvironments
  has_many :environments, through: :shelters

  def self.new_character(name)
    self.create(name: name, thirst: 8, hunger: 8, sleep: 8)
  end

  def create_health
    self.thirst + self.hunger + self.sleep
  end

  def my_stats
    puts "Current Character Stats:"
    puts "Health: #{self.health}"
    puts "Thirst: #{self.thirst}"
    puts "Hunger: #{self.hunger}"
    puts "Sleep: #{self.sleep}"
  end

  def collect_wood(current_location)
    if current_location.resource == "wood"
      puts "Collecting wood..."
      object = self.inventories.where(name: "wood")
      object[0].increment!(:amount, 5)
    else
      puts "You must be in the forest to collect wood!"
    end
  end

  def collect_sand(current_location)
    if current_location.resource == "sand"
      puts "Collecting sand..."
      object = self.inventories.where(name: "sand")
      object[0].increment!(:amount, 5)
    else
      puts "You must be in the desert to collect sand!"
    end
  end

  def collect_water(current_location)
    if current_location.water == true
      puts "Collecting water..."
      object = self.inventories.where(name: "water")
      object[0].increment!(:amount, 5)
    else
      puts "You must be in the forest or by the lake to collect water!"
    end
  end

  def collect_stone(current_location)
    if current_location.resource == "stone"
      puts "Collecting stone..."
      object = self.inventories.where(name: "stone")
      object[0].increment!(:amount, 5)
    else
      puts "You must be in the cave to collect stone!"
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
    puts "You currently have the following resources:"
    puts "#{wood_count} wood"
    puts "#{sand_count} sand"
    puts "#{water_count} water"
    puts "#{stone_count} stone"
    puts "#{food_count} food"
  end

  def drink_water
    object = self.inventories.where(name: "water")
    object_count = object[0].amount
    if object_count > 0
      object[0].decrement!(:amount, 1)
      puts "drinking water..."
      if self.thirst < 10
        self.increment!(:thirst, 1)
        puts "Your thirst stat is now at #{self.thirst}."
      else
        self.thirst = 10
        puts "Your thirst stat is already maxed out."
      end
      puts "You now have #{object[0].amount} water."
    else
      puts "You must collect more water in order to drink!"
    end
    self.update(health: self.create_health)
  end

  def build_shelter(shelter_command, current_location)
    if shelter_command == "wood"
      wood = self.inventories.where(name: "wood")
      wood_count = wood[0].amount
      if wood_count >= 10
        puts "Building wood shelter in the #{current_location.name}..."
        Shelter.create(character_id: self.id, environment_id: current_location.id, material: "wood")
        wood[0].decrement!(:amount, 10)
        puts "You now have #{wood[0].amount} wood."
      else
        puts "You need 10 wood to build your shelter! You can find more wood in the forest."
      end
    elsif shelter_command == "stone"
      stone = self.inventories.where(name: "stone")
      stone_count = stone[0].amount
      if stone_count >= 15
        puts "Building stone shelter in the #{current_location.name}..."
        Shelter.create(character_id: self.id, environment_id: current_location.id, material: "stone")
        stone[0].decrement!(:amount, 15)
        puts "You now have #{stone[0].amount} stone."
      else
        puts "You need 15 stones to build your shelter! You can find more stones in the cave."
      end
    end
  end

  def view_my_shelters
   starter_count = self.shelters.where(environment_id: 1).count
   forest_count = self.shelters.where(environment_id: 2).count
   desert_count = self.shelters.where(environment_id: 3).count
   lake_count = self.shelters.where(environment_id: 4).count
   cave_count = self.shelters.where(environment_id: 5).count
   puts "You have:"
   puts "#{starter_count} shelter(s) in the Starter Area"
   puts "#{forest_count} shelter(s) in the Forest"
   puts "#{desert_count} shelter(s) in the Desert"
   puts "#{lake_count} shelter(s) by the Lake"
   puts "#{cave_count} shelter(s) in the Cave"
  end

  def go_to_sleep(current_location)
    if current_location.shelters.count > 0
      puts "sleeping..."
      if self.sleep < 10
        self.increment!(:sleep, 1)
        puts "Your sleep stat is now at #{self.sleep}."
      else
        self.sleep = 10
        puts "Your sleep stat is already maxed out."
      end
    else
      puts "You must build a shelter in this location before you can rest."
    end
    self.update(health: self.create_health)
  end

  def forage_for_food(forage_command, current_location)
    if forage_command == "berries"
      if current_location.food_type == "berries"
        puts "Foraging for berries..."
        object = self.inventories.where(name: "food")
        object[0].increment!(:amount, 5)
      else
        puts "You must be in the forest to forage for berries!"
      end
    elsif forage_command == "scorpions"
      if current_location.food_type == "scorpions"
        puts "Hunting for scorpions..."
        object = self.inventories.where(name: "food")
        object[0].increment!(:amount, 2)
      else
        puts "You must be in the desert to hunt scorpions!"
      end
    elsif forage_command == "fish"
      if current_location.food_type == "fish"
        puts "Fishing for fish..."
        object = self.inventories.where(name: "food")
        object[0].increment!(:amount, 1)
      else
        puts "You must be by the lake to fish!"
      end
    elsif forage_command == "squirrels"
      if current_location.food_type == "squirrels"
        puts "Hunting for squirrels..."
        object = self.inventories.where(name: "food")
        object[0].increment!(:amount, 1)
      else
        puts "You must be in the cave to hunt squirrels!"
      end
    end
  end

  def eat_food
    object = self.inventories.where(name: "food")
    object_count = object[0].amount
    if object_count > 0
      object[0].decrement!(:amount, 1)
      puts "eating food..."
      if self.hunger < 10
        self.increment!(:hunger, 1)
        puts "Your hunger stat is now at #{self.hunger}."
      else
        self.hunger = 10
        puts "Your hunger stat is already maxed out."
      end
      puts "You now have #{object[0].amount} food."
    else
      puts "You must look for more food in order to eat!"
    end
    self.update(health: self.create_health)
  end

  def decrease_stats
    array = [false, false, false, false, false, false, false, true]
    array.sample
    if array.sample == true
      if self.thirst > 1
        self.decrement!(:thirst, 2)
        puts "Warning! Your thirst stat is down to 2! You must drink more water!" if self.thirst == 2
      end
      if self.hunger > 1
        self.decrement!(:hunger, 2)
        puts "Warning! Your hunger stat is down to 2! You must eat something!" if self.hunger == 2
      end
      if self.sleep > 1
        self.decrement!(:sleep, 2)
        puts "Warning! Your sleep stat is down to 2! You must get some rest!" if self.sleep == 2
      end
      puts "Oh no! Bad luck! Your thirst, hunger, and sleep stats have decreased!"
    end
    self.update(health: self.create_health)
  end

end
