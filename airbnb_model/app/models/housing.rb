class Housing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :admin, class_name: 'User'
  belongs_to :city
  validates :available_beds, :nuity_price, :description,
            :welcome_message, presence: true
  validates :description, length: { maximum: 140 }
  validates :nuity_price, :available_beds,
            numericality: { greater_than: 0 }

  def overlaping_reservation?(daterange)
    # vérifie dans toutes les réservations du listing s'il y a une réservation qui tombe sur le datetime en entrée
    # overlap_bool = false
    # self.bookings.each do |booking|
    #   range = booking.start_date..booking.end_date
    #   overlap_bool = overlap_bool || (range.cover?(datetime))
    # end
    # overlap_bool

    overlap_bool = false
    bookings.each do |booking|
      range = booking.start_date..booking.end_date
      overlap_bool ||= range.overlaps?(daterange)
    end
    overlap_bool
  end
end
