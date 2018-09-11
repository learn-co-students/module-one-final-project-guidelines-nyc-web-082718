class Character < ActiveRecord::Base
  has_many :characterenvironments
  has_many :shelters
  has_many :environments, through: :characterenvironments
  has_many :environments, through: :shelters

  def new_character(name)
    Character.create(name: name, health: 10, thirst: 8, hunger: 8, sleep: 8)
  end

  def
end
