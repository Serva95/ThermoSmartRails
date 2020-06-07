class ChangeDataTypeForRoomidOrarionoff < ActiveRecord::Migration[6.0]
  def change
    change_column :orari_on_off, :room_id, :bigint, limit: 20
  end
end
