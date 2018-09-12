class ShortWord < ActiveRecord::Base
  has_many :wordlinks
  has_many :longwords, through: :wordlinks
end
