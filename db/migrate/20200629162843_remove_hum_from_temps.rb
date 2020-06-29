class RemoveHumFromTemps < ActiveRecord::Migration[6.0]
  def change
    remove_column :temps, :hum
  end
end
