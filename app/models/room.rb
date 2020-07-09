class RoomValidator < ActiveModel::Validator
  def validate(record)
    if record.nome.blank?
      record.errors[:nome] << " non può essere vuoto"
    end
    if record.max_temp.blank?
      record.errors[:max_temp] << " non può essere vuoto"
    end
    if record.min_temp.blank?
      record.errors[:min_temp] << " non può essere vuoto"
    end
    if record.absolute_min.blank?
      record.errors[:absolute_min] << " non può essere vuoto"
    end
  end
end

class Room < ApplicationRecord
  belongs_to :sensor, required: false
  has_many :orari_on_offs, dependent: :destroy

  validates_with RoomValidator

  validates :nome, presence: true
  validates :max_temp, presence: true
  validates :min_temp, presence: true
  validates :absolute_min, presence: true

  def self.join_sensor(id)
    room = Room.find(id)
    if room.sensor_id.nil?
      return room
    else
      Room.joins(:sensor).select("rooms.*", "sensors.nome as sensor_nome", "sensors.id as sensor_id").find(id)
    end
  end
end
