require_relative '../config/environment'
require 'pry'

Environment.create(name: "Starter Area", water: false)
Environment.create(name: "Forest", water: true, resource: "wood", food_type: "berries")
Environment.create(name: "Desert", water: false, resource: "sand", food_type: "scorpions")
Environment.create(name: "Lake", water: true, resource: "water", food_type: "fish")
Environment.create(name: "Cave", water: false, resource: "stone", food_type: "squirrels")
