class SensorValidator < ActiveModel::Validator
  def validate(record)
    if record.id.blank?
      record.errors[:id] << " non può essere vuoto"
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
  has_one :room
  validates_with SensorValidator

  validates :id, presence: true, uniqueness: true
  validates :nome, presence: true
  validates :location, presence: true

  #belongs_to :room
  #belongs_to :user, required: true




end
