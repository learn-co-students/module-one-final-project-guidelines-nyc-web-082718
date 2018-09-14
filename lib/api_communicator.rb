require 'rest-client'
require 'json'
require 'pry'
# require_relative '../app/models/fighter.rb'

def get_fighters_from_api
  response_string = RestClient.get('http://ufc-data-api.ufc.com/api/v1/us/fighters')
  response_hash = JSON.parse(response_string)
  response_hash
end


def match_announcement()
  puts ""
end
