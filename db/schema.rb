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

ActiveRecord::Schema.define(version: 2018_11_27_231115) do

  create_table "orders", force: :cascade do |t|
    t.integer "quote_id", null: false
    t.string "status", default: "unfulfilled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ourrencies", force: :cascade do |t|
    t.string "code", null: false
    t.decimal "exchange_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_ourrencies_on_code"
  end

  create_table "quotes", force: :cascade do |t|
    t.integer "currency_id", null: false
    t.decimal "requested_value"
    t.decimal "offered_value"
    t.decimal "exchange_rate"
    t.string "status", default: "offered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
