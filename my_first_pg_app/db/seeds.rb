# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Rails.application.eager_load!
models_array = ApplicationRecord.descendants

puts "Effacement des bases de données des modèles #{models_array.join(' ')}."
puts '-' * 50
puts

models_array.each(&:destroy_all)
