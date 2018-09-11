class Environment < ActiveRecord::Base
  has_many :characterenvironments
  has_many :shelters
  has_many :characters, through: :characterenvironments
  has_many :characters, through: :shelters


  def self.create_environments
    starter_area = Environment.create(name: "Starter Area", water: false)
    forest = Environment.create(name: "Forest", water: true, resource: "wood")
    desert = Environment.create(name: "Desert", water: false, resource: "sand")
    lake = Environment.create(name: "Lake", water: true, resource: "water")
  end
end
