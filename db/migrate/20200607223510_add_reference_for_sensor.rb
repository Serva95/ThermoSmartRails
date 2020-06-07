class AddReferenceForSensor < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :temps, :sensors
    add_foreign_key :rooms, :sensors
  end
end
