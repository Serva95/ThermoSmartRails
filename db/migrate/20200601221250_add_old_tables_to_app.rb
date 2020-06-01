class AddOldTablesToApp < ActiveRecord::Migration[6.0]
  def change

    create_table "orari_on_off", id: :integer, force: :cascade do |t|
      t.integer "room_id", null: false
      t.integer "giorno", :limit => 2, null: false
      t.integer "fascia", :limit => 2, null: false
      t.time "orario_accensione", null: false
      t.time "orario_spegnimento", null: false
      t.index ["room_id"], name: "index_room_id"
    end

    create_table "rooms", id: :integer, force: :cascade do |t|
      t.string "nome", :limit => 64, null: false
      t.decimal "max_temp", precision: 3, scale: 1, null: false
      t.decimal "min_temp", precision: 3, scale: 1, null: false
      t.decimal "absolute_min", precision: 3, scale: 1, null: false
      t.integer "sensor_id", null: true
      t.index ["sensor_id"], name: "index_rooms_on_sensor_id"
    end

    create_table "sensors", id: :integer, force: :cascade do |t|
      t.string "nome", :limit => 64, null: false
      t.string "location", :limit => 64, null: false
      t.string "unique_id", :limit => 64, null: true
      t.index ["unique_id"], name: "index_unique_id", unique: true
    end

    create_table "temps", id: :bigint, force: :cascade do |t|
      t.decimal "temp", precision: 3, scale: 1, null: false
      t.decimal "hum", precision: 3, scale: 1, null: false
      t.datetime "date", null: false
      t.integer "sensor_id", null: true
      t.index ["date"], name: "index_date"
      t.index ["sensor_id"], name: "index_temps_on_sensor_id"
    end

  end
end
