# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rails.application.eager_load!
models_array = [City, User, Housing, Booking]

# Sets the locale to "France":
Faker::Config.locale = 'fr'

puts "Effacement des bases de données des modèles #{models_array.join(' ')}."
puts '-' * 50
puts
models_array.each(&:destroy_all)
puts 'Effectué'
puts
puts "Création de tables de données pour #{models_array.join(' ')}"
puts '-' * 50
puts

models_items_count = Hash[ [['City', 10], ['User', 20],
                            ['Booking', 500], ['Housing', 50]] ]

models_array.each do |model|
  puts "Création de #{models_items_count[model.name]} items pour #{model.name}"
  models_items_count[model.name].times do
    i = 0
    case model.name
    when 'City'
      while true # Faker génère parfois des zip code pas français comme 97670
        zip_code = Faker::Address.unique.zip_code
        break if zip_code =~ /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/
      end

      c = model.create(city_name: Faker::Address.unique.city,
                       zip_code: zip_code)
      i += 1

    when 'User'
      model.create(first_name: Faker::Name.unique.first_name,
                   email: Faker::Internet.unique.email,
                   phone_number: Faker::PhoneNumber.unique.phone_number,
                   description: Faker::Lorem.sentence)
    when 'Housing'
      admin_offset = rand(User.count)
      guest_offset = rand(User.count)
      city_offset = rand(City.count)

      my_housing = model.create(admin: User.offset(admin_offset).first,
                                city: City.offset(city_offset).first,
                                available_beds: rand(1..10),
                                nuity_price: rand(1..150),
                                description: Faker::Lorem.paragraph_by_chars(130, false),
                                has_wifi: [true, false].sample,
                                welcome_message:
      Faker::Lorem.paragraph_by_chars(130, false))

      5.times do
        past_start_date = Time.local(rand(2000..2018),
                                     rand(1..12),
                                     rand(1..28),
                                     rand(24),
                                     rand(60),
                                     rand(60))

        Booking.create(guest: User.offset(guest_offset).first,
                       housing: my_housing,
                       is_paid: [false, true].sample,
                       start_date: past_start_date,
                       end_date: past_start_date +
          (60 * 60 * 24 * rand(1..10)))

        future_start_date = Time.local(rand(2019..2020),
                                       rand(3..12),
                                       rand(1..28),
                                       rand(24),
                                       rand(60),
                                       rand(60))

        Booking.create(guest: User.offset(guest_offset).first,
                       housing: my_housing,
                       is_paid: [false, true].sample,
                       start_date: future_start_date,
                       end_date: future_start_date +
          (60 * 60 * 24 * rand(1..10)))
      end

    end
  end
end

puts 'Effectué'
puts
puts 'Impression des 3 derniers items de chaque table'
puts '-' * 50
puts

models_array.each do |model|
  puts "#{model.name} : #{model.count} items"
  unless models_items_count[model.name] == model.count
    puts "PROBLEME de Validation ? Le nombre d'items est différent du nbre prévu : #{models_items_count[model.name]}"
  end
  puts
  tp model.last(3)
  puts
end
