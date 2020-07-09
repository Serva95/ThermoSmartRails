class TempValidator < ActiveModel::Validator
  def validate(record)
    if record.temp.blank?
      record.errors[:temp] << " non può essere vuoto"
    end
    if record.sensor_id.blank?
      record.errors[:sensor_id] << " non può essere vuoto"
    end
  end
end

class Temp < ApplicationRecord
  attr_accessor :day
  belongs_to :sensor

  validates_with TempValidator

  validates :temp, presence: true
  validates :sensor_id, presence: true

  def self.find_room_temps(sensor_id)
    temps = Temp.select("id", "temp", "created_at").where(:sensor_id => sensor_id).order(created_at: :desc).limit(100)
    temps.reverse
  end

  def self.get_medium_temps(sensor_id, days)
    if days == "7" || days == "15" || days == "30" || days == "60" || days == "100"
      meds = Temp.where(:sensor_id => sensor_id).select("CAST(created_at AS DATE) AS giorno", "AVG(temp) AS temp").group(:giorno).order(giorno: :desc).limit(days)
      meds.reverse
    end
  end

  def self.read_last(sensor_id)
    Temp.where(:sensor_id => sensor_id).order(created_at: :desc).first
  end

  def self.last_temp_of_rooms(rooms)
    h = Hash.new
    rooms.each do |room|
      unless room.sensor_id.blank?
        last = read_last(room.sensor_id)
        h.store(room.sensor_id, [last.nil? ? nil : last.temp, last.nil? ? nil : last.created_at.strftime("%d-%m-%Y - %T")])
      end
    end
    h
  end

  def self.update_chart_temp(previous_temp_time, sensor_id)
    last_read = read_last(sensor_id)
    if last_read.created_at.strftime("%T") == previous_temp_time
      nil
    else
      last_read
    end
  end

end
