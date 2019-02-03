class User < ApplicationRecord
  has_many :housings, dependent: :destroy, foreign_key: 'admin_id'
  has_many :bookings, dependent: :destroy, foreign_key: 'guest_id'
  validates :first_name, :email, :phone_number, presence: true
  validates :first_name, :email, :phone_number,
            uniqueness: { case_sensitive: false }
  validates :email, format: { with:
    /\A([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})\z/,
                              message: 'Please enter an email' }
  validates :phone_number, format: { with:
     /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/,
                                     message: 'please enter a valid French number' }
end
