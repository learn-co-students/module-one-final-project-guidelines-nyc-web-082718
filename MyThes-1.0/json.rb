require 'rubygems'
require 'json'
require "pry"

file = File.open('./th_en_US_new.dat', 'r')
binding.pry
JSON.parse(file)
