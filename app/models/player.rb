class Player < ActiveRecord::Base
  has_many :fights
  has_many :fighters, through: :fights

  # def fighter_match
  #   binding.pry
  #   Fighter.all.where(self.weightclass == Fighter["weightclass"])
  # end
  #
  # def fighter_select
  #   fighter_match.sample
  # end

end

binding.pry
