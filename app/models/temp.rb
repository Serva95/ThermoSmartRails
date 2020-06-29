class Temp < ApplicationRecord
  belongs_to :sensor

  def self.find_room_temps(room_id)
    room = Room.select("sensor_id").find(room_id)
    temps = Temp.select("id", "temp", "created_at").where("sensor_id = ?", room.sensor_id).order(created_at: :desc).limit(100)
    temps.reverse
  end

end
