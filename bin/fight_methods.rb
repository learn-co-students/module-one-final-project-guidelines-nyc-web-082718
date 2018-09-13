



  def fighter_generator
    opponents = []
    5.times do
      fighter = Fighter.fighter_select
      opponents << fighter
    end
    1.times do
      opponents << Fighter.champ_select
    end
    opponents
  end



# def match_loop(array)
#   array.each do |fighter|
#     Fight.create(user_id: Player.last.id, fighter_id: fighter.id)
#
#
#
#
#
#
#
#
#
#   end
# end
# first_match_announcement(fighter_name)
# fight(fighter_name)
