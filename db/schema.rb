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

ActiveRecord::Schema.define(version: 2021_03_06_205707) do

  create_table "items", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "list_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "rank"
    t.index ["list_id"], name: "index_items_on_list_id"
    t.index ["rank", "list_id"], name: "index_items_on_rank_and_list_id", unique: true
  end

  create_table "lists", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "rank"
    t.bigint "session_id", null: false
    t.index ["rank", "session_id"], name: "index_lists_on_rank_and_session_id", unique: true
    t.index ["session_id"], name: "index_lists_on_session_id"
  end

  create_table "sessions", charset: "utf8mb4", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  add_foreign_key "lists", "sessions"
end
