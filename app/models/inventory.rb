class Inventory < ActiveRecord::Base
  belongs_to :character

  def self.start_inventory(character_id=nil)
    wood = Inventory.create(name: "wood", amount: 0, character_id: character_id)
    stone = Inventory.create(name: "stone", amount: 0, character_id: character_id)
    sand = Inventory.create(name: "sand", amount: 0, character_id: character_id)
    water = Inventory.create(name: "water", amount: 0, character_id: character_id)
  end
end
