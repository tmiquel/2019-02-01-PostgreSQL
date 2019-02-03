class City < ApplicationRecord
  has_many :housings
  has_many :bookings, through: :housings
end
