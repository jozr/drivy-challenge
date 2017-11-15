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

ActiveRecord::Schema.define(version: 2) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", id: :serial, force: :cascade do |t|
    t.integer "price_per_day"
    t.integer "price_per_km"
  end

  create_table "rentals", id: :serial, force: :cascade do |t|
    t.integer "car_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "distance"
    t.index ["car_id"], name: "index_rentals_on_car_id"
  end

  add_foreign_key "rentals", "cars"
end
