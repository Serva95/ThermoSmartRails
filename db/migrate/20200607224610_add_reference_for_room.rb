class AddReferenceForRoom < ActiveRecord::Migration[6.0]
  def change
    rename_table :orari_on_off,  "orari_on_offs"
    add_foreign_key :orari_on_offs, :rooms
  end
end
