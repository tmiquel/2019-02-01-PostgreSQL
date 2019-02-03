class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.belongs_to :housing, index: true
      t.references :guest, index: true
      t.boolean :is_paid
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
