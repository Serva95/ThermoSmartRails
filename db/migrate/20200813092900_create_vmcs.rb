class CreateVmcs < ActiveRecord::Migration[6.0]
  def change
    create_table :vmcs do |t|
      t.boolean "stato_attuale", default: false, null: false
      t.boolean "impostazione_funzione", default: false, null: false
      t.time "programmed_on_time", default: nil, null: true
      t.time "programmed_off_time", default: nil, null: true
    end
    change_column :vmcs, :id, :string, :limit => 64, null: false
  end
end
