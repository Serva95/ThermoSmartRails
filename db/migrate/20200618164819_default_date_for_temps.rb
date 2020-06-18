class DefaultDateForTemps < ActiveRecord::Migration[6.0]
  def change
    rename_column :temps, :date, :created_at
  end
end
