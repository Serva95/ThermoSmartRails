class AddManualControlParamsToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, "manual_active", :boolean, default: false, null: false
    add_column :rooms, "manual_inactive", :boolean, default: false, null: false
    add_column :rooms, "manual_off", :boolean, default: false, null: false
  end
end
