class Fighter < ActiveRecord::Base
  has_many :fights
  has_many :players, through: :fights
end
