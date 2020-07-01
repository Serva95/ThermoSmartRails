class Temp < ApplicationRecord
  attr_accessor :day

  belongs_to :sensor

  def self.find_room(room_id)
    Room.select("sensor_id").find(room_id)
  end

  def self.find_room_temps(room)
    temps = Temp.select("id", "temp", "created_at").where("sensor_id = ?", room.sensor_id).order(created_at: :desc).limit(100)
    temps.reverse
  end

  def self.get_medium_temps(room, days)
    Temp.where("sensor_id = ?", room.sensor_id).select("CAST(created_at AS DATE) AS giorno", "AVG(temp) AS temp").group(:giorno).order(giorno: :desc).limit(days)
  end

  def self.read_last(room)

  end

end
