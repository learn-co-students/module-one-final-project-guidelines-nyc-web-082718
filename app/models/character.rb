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
    puts "Health: #{self.create_health}"
    puts "Thirst: #{self.thirst}"
    puts "Hunger: #{self.hunger}"
    puts "Sleep: #{self.sleep}"
  end

  def collect_wood(current_location, forest)
    if current_location == forest
      puts "Collecting wood..."
      object = self.inventories.where(name: "wood")
      object[0].increment!(:amount, 5)
    else
      puts "You must be in the forest to collect wood!"
    end
  end

  def collect_sand(current_location, desert)
    if current_location == desert
      puts "Collecting sand..."
      object = self.inventories.where(name: "sand")
      object[0].increment!(:amount, 5)
    else
      puts "You must be in the desert to collect sand!"
    end
  end

  def collect_water(current_location, forest, lake)
    if current_location == forest || lake
      puts "Collecting water..."
      object = self.inventories.where(name: "water")
      object[0].increment!(:amount, 5)
    else
      puts "You must be in the forest or by the lake to collect water!"
    end
  end

  def collect_stone(current_location, cave)
    if current_location == cave
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
    puts "You currently have the following resources:"
    puts "#{wood_count} wood"
    puts "#{sand_count} sand"
    puts "#{water_count} water"
    puts "#{stone_count} stone"
  end

  def drink_water
    object = self.inventories.where(name: "water")
    object_count = object[0].amount
    if object_count > 0
      object[0].decrement!(:amount, 1)
      puts "drinking water..."
      if self.thirst < 10
        self.increment!(:thirst, 1)
        "Your thirst stat is now at #{self.thirst}."
      else
        self.thirst = 10
        "Your thirst stat is already maxed out."
      end
      puts "You now have #{object[0].amount} water."
    else
      puts "You must collect more water in order to drink!"
    end
  end

  def build_shelter(shelter_command, current_location)
    if shelter_command == "wood"
      wood = self.inventories.where(name: "wood")
      wood_count = wood[0].amount
      if wood_count >= 10
        puts "Building wood shelter in the #{current_location[0].name}..."
        Shelter.create(character_id: self.id, environment_id: current_location[0].id, material: "wood")
        wood[0].decrement!(:amount, 10)
        puts "You now have #{wood[0].amount} wood."
      else
        puts "You need 10 wood to build your shelter! You can find more wood in the forest."
      end
    elsif shelter_command == "stone"
      stone = self.inventories.where(name: "stone")
      stone_count = stone[0].amount
      if stone_count >= 15
        puts "Building stone shelter in the #{current_location[0].name}..."
        Shelter.create(character_id: self.id, environment_id: current_location[0].id, material: "stone")
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
    if current_location[0].shelters.empty? == false
      if self.sleep < 10
        self.increment!(:sleep, 1)
        "Your sleep stat is now at #{self.sleep}."
      else
        self.sleep = 10
        "Your sleep stat is already maxed out."
      end
      puts "sleeping..."
    else
      puts "You must build a shelter in this location before you can rest."
    end
  end


end
