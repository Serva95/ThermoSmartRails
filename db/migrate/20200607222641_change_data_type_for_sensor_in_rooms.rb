class ChangeDataTypeForSensorInRooms < ActiveRecord::Migration[6.0]
  def change
    change_column :rooms, :sensor_id, :string, limit: 64
    change_column :temps, :sensor_id, :string, limit: 64
  end
end
