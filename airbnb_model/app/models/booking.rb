class OverlapValidator < ActiveModel::Validator
  def validate(record)
    range = (options[:fields][0]..options[:fields][1])
    if record.housing.overlaping_reservation?(range)
      record.errors[:base] << 'Overlapping booking'
    end
  end
end

class Booking < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :housing
  validates  :start_date, :end_date, presence: true
  validates :is_paid, inclusion: [true, false] # https://8thlight.com/blog/will-warner/2013/12/29/validates-presence-of-false.html
  validate do |booking|
    StartBeforeEndValidator.new(booking,
                                booking.start_date, booking.end_date).validate
  end
  validates_with OverlapValidator, fields: %i[start_date end_date]

  def duration
    diff_secs = (end_date - start_date).to_time
    format('%d j %02d:%02d:%02d', (diff_secs / (3600 * 24)), (diff_secs / 3600) % 24, (diff_secs / 60) % 60, diff_secs % 60)
  end
end

class StartBeforeEndValidator < ActiveModel::Validator
  def initialize(booking, start_date, end_date)
    @booking = booking
    @start_date = start_date
    @end_date = end_date
  end

  def validate
    unless @start_date < @end_date
      @booking.errors.add(:start_date, 'must be before end time')
    end
  end
end
