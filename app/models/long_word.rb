class LongWord < ActiveRecord::Base
  has_many :wordlinks
  has_many :shortwords, through: :wordlinks
end
