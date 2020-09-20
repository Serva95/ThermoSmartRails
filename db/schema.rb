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

ActiveRecord::Schema.define(version: 2020_08_13_092900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orari_on_offs", id: :serial, force: :cascade do |t|
    t.bigint "room_id", null: false
    t.integer "giorno", limit: 2, null: false
    t.integer "fascia", limit: 2, null: false
    t.time "orario_accensione", null: false
    t.time "orario_spegnimento", null: false
    t.index ["room_id"], name: "index_room_id"
  end

  create_table "rooms", id: :serial, force: :cascade do |t|
    t.string "nome", limit: 64, null: false
    t.decimal "max_temp", precision: 3, scale: 1, null: false
    t.decimal "min_temp", precision: 3, scale: 1, null: false
    t.decimal "absolute_min", precision: 3, scale: 1, null: false
    t.string "sensor_id", limit: 64
    t.boolean "manual_active", default: false, null: false
    t.boolean "manual_inactive", default: false, null: false
    t.boolean "manual_off", default: false, null: false
    t.index ["sensor_id"], name: "index_rooms_on_sensor_id"
  end

  create_table "sensors", id: :serial, limit: 64, force: :cascade do |t|
    t.string "nome", limit: 64, null: false
    t.string "location", limit: 64, null: false
  end

  create_table "temps", force: :cascade do |t|
    t.decimal "temp", precision: 3, scale: 1, null: false
    t.datetime "created_at", null: false
    t.string "sensor_id", limit: 64
    t.index ["created_at"], name: "index_date"
    t.index ["sensor_id"], name: "index_temps_on_sensor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", limit: 64
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vmcs", id: :serial, limit: 64, force: :cascade do |t|
    t.boolean "stato_attuale", default: false, null: false
    t.boolean "impostazione_funzione", default: false, null: false
    t.time "programmed_on_time"
    t.time "programmed_off_time"
  end

  add_foreign_key "orari_on_offs", "rooms"
  add_foreign_key "rooms", "sensors"
  add_foreign_key "temps", "sensors"
end
