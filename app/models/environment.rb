class Environment < ActiveRecord::Base
  has_many :characterenvironments
  has_many :shelters
  has_many :characters, through: :characterenvironments
  has_many :characters, through: :shelters


  def self.create_environment
    current_location = Environment.create(name: "Starter Area", water: false)
  end
end
