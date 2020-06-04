class ChangeSensorId < ActiveRecord::Migration[6.0]
  def change
    change_column :sensors, :id, :string, limit: 64, null: false, unique: true
    remove_column :sensors, :unique_id
  end
end
