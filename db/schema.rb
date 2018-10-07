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

ActiveRecord::Schema.define(version: 2018_10_07_123711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "prefecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_cities_on_prefecture_id"
  end

  create_table "clovas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "line_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "text"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "patrol_user_cities", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_patrol_user_cities_on_city_id"
    t.index ["user_id"], name: "index_patrol_user_cities_on_user_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suspicious_person_infos", force: :cascade do |t|
    t.datetime "published_at"
    t.string "text"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source_url"
    t.index ["city_id"], name: "index_suspicious_person_infos_on_city_id"
  end

  create_table "user_clovas", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "clova_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clova_id"], name: "index_user_clovas_on_clova_id"
    t.index ["user_id"], name: "index_user_clovas_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "line_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "displayName"
    t.string "pictureUrl"
  end

  add_foreign_key "cities", "prefectures"
  add_foreign_key "messages", "users"
  add_foreign_key "patrol_user_cities", "users"
  add_foreign_key "suspicious_person_infos", "cities"
  add_foreign_key "user_clovas", "clovas"
  add_foreign_key "user_clovas", "users"
end
