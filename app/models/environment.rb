class Environment < ActiveRecord::Base
  has_many :characterenvironments
  has_many :shelters
  has_many :characters, through: :characterenvironments
  has_many :characters, through: :shelters


  def self.create_environment(character_id=nil)
    current_location = Environment.create(name: "Starter Area", water: false)
    CharacterEnvironment.create(environment_id: current_location.id, character_id: character_id)
  end
end
