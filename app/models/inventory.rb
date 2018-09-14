class Inventory < ActiveRecord::Base
  belongs_to :character

  def self.start_inventory(character_id=nil)
    Inventory.create(name: "wood", amount: 0, character_id: character_id)
    Inventory.create(name: "stone", amount: 0, character_id: character_id)
    Inventory.create(name: "sand", amount: 0, character_id: character_id)
    Inventory.create(name: "water", amount: 0, character_id: character_id)
    Inventory.create(name: "food", amount: 0, character_id: character_id)
  end
end
