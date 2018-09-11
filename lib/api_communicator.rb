require 'rest-client'
require 'json'
require 'pry'


def get_fighters_from_api

  response_string = RestClient.get('http://ufc-data-api.ufc.com/api/v1/us/fighters')
  response_hash = JSON.parse(response_string)
  binding.pry
end

def sort_by_weight_class(weight_class)
  response_hash

end
"first_name "  " last_name "
weight class
w/l ratio
binding.pry


fred

heavy weight
