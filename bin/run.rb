require_relative '../config/environment'
require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
gender = get_gender.downcase
weight_class = get_weight_class(gender)
name = get_name
formatted_name = format_name(name)
nickname = get_nickname(formatted_name)
formatted_nickname = format_nickname(nickname)
complete_player_creation(formatted_name, formatted_nickname, gender, weight_class)

#
# sorter = sort_fighters_by_weight_class(weight_class)
# rank_fighters(sorter)
#
# binding.pry
# puts "HELLO WORLD"

# brooke is testing if dope shit works
