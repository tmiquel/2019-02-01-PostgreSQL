class City < ApplicationRecord
  has_many :housings
  has_many :bookings, through: :housings
  validates :city_name,
            presence: true
  validates :city_name, uniqueness: { case_sensitive: false }
  validates :zip_code,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/,
                      message: 'Please enter a French zip code' }
end
