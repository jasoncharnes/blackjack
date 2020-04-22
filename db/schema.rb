# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_19_201350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "hand_id"
    t.integer "rank", null: false
    t.string "suit", null: false
    t.integer "position"
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_cards_on_game_id"
    t.index ["hand_id"], name: "index_cards_on_hand_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "session_id", null: false
    t.string "workflow_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_games_on_session_id"
  end

  create_table "hands", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.boolean "dealer", default: false, null: false
    t.string "workflow_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_hands_on_game_id"
  end

  add_foreign_key "cards", "games"
  add_foreign_key "cards", "hands"
  add_foreign_key "hands", "games"
end
