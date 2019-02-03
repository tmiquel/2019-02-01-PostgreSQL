# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_202_205_052) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bookings', force: :cascade do |t|
    t.bigint 'housing_id'
    t.bigint 'guest_id'
    t.boolean 'is_paid'
    t.datetime 'start_date'
    t.datetime 'end_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['guest_id'], name: 'index_bookings_on_guest_id'
    t.index ['housing_id'], name: 'index_bookings_on_housing_id'
  end

  create_table 'cities', force: :cascade do |t|
    t.string 'city_name'
    t.string 'zip_code'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'housings', force: :cascade do |t|
    t.bigint 'admin_id'
    t.bigint 'city_id'
    t.integer 'available_beds'
    t.integer 'nuity_price'
    t.text 'description'
    t.boolean 'has_wifi'
    t.text 'welcome_message'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['admin_id'], name: 'index_housings_on_admin_id'
    t.index ['city_id'], name: 'index_housings_on_city_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name'
    t.string 'email'
    t.string 'phone_number'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
