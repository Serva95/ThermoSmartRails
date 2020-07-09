class SensorValidator < ActiveModel::Validator
  def validate(record)
    if record.id.blank?
      record.errors[:id] << " non può essere vuoto"
      end
    if record.id.length < 32
      record.errors[:id] << " non può essere minore di 32 caratteri"
    end
    if record.nome.blank?
      record.errors[:nome] << " non può essere vuoto"
    end
    if record.location.blank?
      record.errors[:location] << " non può essere vuoto"
    end
  end
end

class Sensor < ApplicationRecord
  has_many :temps, dependent: :destroy
  has_one :room, dependent: :nullify
  validates_with SensorValidator

  validates :id, presence: true, uniqueness: true
  validates :nome, presence: true
  validates :location, presence: true

  def self.not_ass_sensors_plus_actual(actual_sensor_id)
    Sensor.left_outer_joins(:room).where("rooms.sensor_id is null || rooms.sensor_id = ?", actual_sensor_id)
  end

  def self.find_not_associated_sensors
    Sensor.left_outer_joins(:room).where("rooms.sensor_id is null")
  end


end
