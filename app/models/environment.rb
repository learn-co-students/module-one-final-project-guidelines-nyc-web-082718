class Environment < ActiveRecord::Base
  has_many :characterenvironments
  has_many :shelters
  has_many :characters, through: :characterenvironments
  has_many :characters, through: :shelters


  def self.create_environments(character_id=nil)
    starter_area = Environment.create(name: "Starter Area", water: false)
    forest = Environment.create(name: "Forest", water: true, resource: "wood", food_type: "berries")
    desert = Environment.create(name: "Desert", water: false, resource: "sand", food_type: "scorpions")
    lake = Environment.create(name: "Lake", water: true, resource: "water", food_type: "fish")
    cave = Environment.create(name: "Cave", water: false, resource: "stone", food_type: "squirrels")
    CharacterEnvironment.create(environment_id: starter_area.id, character_id: character_id)
    CharacterEnvironment.create(environment_id: forest.id, character_id: character_id)
    CharacterEnvironment.create(environment_id: desert.id, character_id: character_id)
    CharacterEnvironment.create(environment_id: lake.id, character_id: character_id)
    CharacterEnvironment.create(environment_id: cave.id, character_id: character_id)
  end
end
