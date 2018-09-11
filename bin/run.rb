require_relative '../config/environment'
require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
gender = get_gender.downcase
weight_class = get_weight_class(gender)
name = get_name
nickname = get_nickname

sorter = sort_fighters_by_weight_class(weight_class)
rank_fighters(sorter)

binding.pry
puts "HELLO WORLD"
