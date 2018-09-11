require 'rest-client'
require 'json'
require 'pry'



def get_fighters_from_api
  response_string = RestClient.get('http://ufc-data-api.ufc.com/api/v1/us/fighters')
  response_hash = JSON.parse(response_string)
  response_hash
end

def sort_fighters_by_weight_class(weight_class)
  fighters_sorted_by_weight_class = get_fighters_from_api.select do |dataset|
    dataset['weight_class'] == weight_class
  end
  fighters_sorted_by_weight_class
end


def rank_fighters(array)
  fighters_ranked = array.sort_by {|fighter| fighter["wins"]}
  fighters_ranked
end
