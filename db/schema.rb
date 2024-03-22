# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_22_061909) do
  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.string "street"
    t.string "landmark"
    t.string "label"
    t.integer "postal_code"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.decimal "price"
    t.string "size"
    t.string "image_url"
    t.string "ingredints_basic"
    t.string "fruits"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.decimal "price"
    t.string "size"
    t.string "image_url"
    t.string "ingredints_basic"
    t.string "fruits"
    t.integer "restaurant_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["restaurant_id"], name: "index_items_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "address"
    t.integer "working_days", default: 0, null: false
    t.datetime "open_time"
    t.datetime "close_time"
    t.string "documents"
    t.text "details"
    t.string "owner_name"
    t.string "email"
    t.integer "mobile_number"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "restaurents", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "address"
    t.integer "working_days", default: 0, null: false
    t.datetime "open_time"
    t.datetime "close_time"
    t.string "documents"
    t.text "details"
    t.string "owner_name"
    t.string "email"
    t.integer "mobile_number"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_restaurents_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.integer "verification_code"
    t.integer "phone_number"
    t.text "bio"
    t.string "profile_image"
    t.string "role"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.string "restaurant_name"
    t.string "owner_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "foods", "users"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "restaurants"
  add_foreign_key "restaurants", "users"
  add_foreign_key "restaurents", "users"
end
