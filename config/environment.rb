require 'bundler'
require 'sqlite3'
require 'rake'
require 'sinatra/activerecord/rake'
Bundler.require
require_all 'lib'
require_all 'app'

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
