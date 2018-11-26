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

ActiveRecord::Schema.define(version: 2018_11_18_192939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "dish_id"
    t.bigint "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_orders_on_dish_id"
    t.index ["poll_id"], name: "index_orders_on_poll_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "poll_responses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "restaurant_id"
    t.bigint "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_poll_responses_on_poll_id"
    t.index ["restaurant_id"], name: "index_poll_responses_on_restaurant_id"
    t.index ["user_id"], name: "index_poll_responses_on_user_id"
  end

  create_table "polls", force: :cascade do |t|
    t.date "date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_time"
    t.index ["user_id"], name: "index_polls_on_user_id"
  end

  create_table "restaurant_polls", force: :cascade do |t|
    t.integer "votes"
    t.bigint "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "restaurant_id"
    t.bigint "dish_id"
    t.index ["dish_id"], name: "index_restaurant_polls_on_dish_id"
    t.index ["poll_id"], name: "index_restaurant_polls_on_poll_id"
    t.index ["restaurant_id"], name: "index_restaurant_polls_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dishes", "restaurants"
  add_foreign_key "orders", "dishes"
  add_foreign_key "orders", "polls"
  add_foreign_key "orders", "users"
  add_foreign_key "poll_responses", "polls"
  add_foreign_key "poll_responses", "restaurants"
  add_foreign_key "poll_responses", "users"
  add_foreign_key "polls", "users"
  add_foreign_key "restaurant_polls", "dishes"
  add_foreign_key "restaurant_polls", "polls"
  add_foreign_key "restaurant_polls", "restaurants"
end
