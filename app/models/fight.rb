class Fight < ActiveRecord::Base
   belongs_to :fighter
   belongs_to :player
end
