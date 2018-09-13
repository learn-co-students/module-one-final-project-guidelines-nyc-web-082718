class Fighter < ActiveRecord::Base
  has_many :fights
  has_many :players, through: :fights

  def self.possible_opponents
    player_weight = Player.last.weightclass
    where(weightclass: player_weight)
  end

  def self.fighter_select
    self.possible_opponents.where(champ: false).sample
  end

  def self.champ_select
    self.possible_opponents.where(champ: true).sample
  end

  def fighter_name
    self.name
  end

  def id_select
    self.id
  end

# binding.pry
end
