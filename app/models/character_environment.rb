class CharacterEnvironment < ActiveRecord::Base
  belongs_to :character
  belongs_to :environment
end
