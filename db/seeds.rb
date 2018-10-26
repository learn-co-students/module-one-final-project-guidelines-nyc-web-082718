# fighter1 = Figther.create(name: "Brock Lesnar", wins: 7, weightclass: "Heavyweight", champ: true)

# t.string :name
# t.integer :wins
# t.string :weightclass
# t.boolean :champ

# require 'pry'
# require_relative '../app/models/fighter.rb'
# require_relative '../lib/api_communicator.rb'
# require 'rest-client'
# require 'json'
# require 'active_record'
#
# def populate_fighters_table
#   response_hash.each do |fighter|
#     name = fighter["first_name"] + " " + fighter["last_name"]
#     champ = fighter[belt_thumbnail] ? true : false
#     Fighter.create(name: name, wins: fighter["wins"], weightclass: fighter["weight_class"], champ: champ)
#   end
#   binding.pry
# end
#
# binding.pry
