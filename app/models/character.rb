class Character < ActiveRecord::Base
  has_many :inventories
  has_many :characterenvironments
  has_many :shelters
  has_many :environments, through: :characterenvironments
  has_many :environments, through: :shelters

  def self.new_character(name)
    self.create(name: name, health: 10, thirst: 8, hunger: 8, sleep: 8)
  end

  def collect_wood
    if current_location == forest
      puts "Collecting wood..."
      object = self.inventories.where(name: "wood")
      object.increment!(:amount, 5)
    else
      puts "You must be in the forest to collect wood!"
    end
  end
end
