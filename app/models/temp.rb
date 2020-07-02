class Temp < ApplicationRecord
  attr_accessor :day

  belongs_to :sensor

  def self.find_room_temps(sensor_id)
    temps = Temp.select("id", "temp", "created_at").where("sensor_id = ?", sensor_id).order(created_at: :desc).limit(100)
    temps.reverse
  end

  def self.get_medium_temps(sensor_id, days)
    meds = Temp.where("sensor_id = ?", sensor_id).select("CAST(created_at AS DATE) AS giorno", "AVG(temp) AS temp").group(:giorno).order(giorno: :desc).limit(days)
    meds.reverse
  end

  def self.read_last(sensor_id)
    Temp.where("sensor_id = ?", sensor_id).order(created_at: :desc).first
  end

end
