require_relative "../config/environment"
require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"
require_relative "../db/seeds.rb"

response_hash = get_fighters_from_api

if Fighter.first == nil
  response_hash.each do |fighter|
    name = fighter["first_name"] + " " + fighter["last_name"]
    champ = fighter["belt_thumbnail"] ? true : false
    Fighter.create(name: name, wins: fighter["wins"], weightclass: fighter["weight_class"], champ: champ)
  end
end

welcome
gender = get_gender.downcase
weight_class = get_weight_class(gender)
Fighter.possible_opponents
player_name = get_name
formatted_name = format_name(player_name)
nickname = get_nickname(formatted_name)
formatted_nickname = format_nickname(nickname)
complete_player_creation(formatted_name, formatted_nickname, gender, weight_class)
fighter = Fighter.fighter_select
id = fighter.id
fighter_name = fighter.name
match_1 = Fight.create(user_id: Player.last.id, fighter_id: id)
first_match_announcement(fighter_name)

# puts Player.all.last.name

#
# sorter = sort_fighters_by_weight_class(weight_class)
# rank_fighters(sorter)
#
# binding.pry
# puts "HELLO WORLD"

# Fighter.all.where(id: num)
