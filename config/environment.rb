require 'pry'
require 'bundler'
require 'json'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

# RestClient.get('api.datamuse.com/words')

# binding.pry
