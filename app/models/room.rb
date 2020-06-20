class Room < ApplicationRecord
  belongs_to :sensor, required: false
  has_many :orari_on_offs, dependent: :destroy

  def self.join_sensor(id)
    room = Room.find(id)
    if room.sensor_id.nil?
      return room
    else
      Room.joins(:sensor).select("rooms.*", "sensors.nome as sensor_nome", "sensors.id as sensor_id").find(id)
    end
  end
end
