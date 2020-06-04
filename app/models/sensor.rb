class SensorValidator < ActiveModel::Validator
  def validate(record)
    if record.id.blank?
      record.errors[:id] << "ID non può essere vuoto"
    end
    if record.nome.blank?
      record.errors[:nome] << "Nome non può essere vuoto"
    end
    if record.location.blank?
      record.errors[:location] << "Location non può essere vuoto"
    end
  end
end

class Sensor < ApplicationRecord
  validates :id, presence: true
  validates :nome, presence: true
  validates :location, presence: true

  #belongs_to :room
  #belongs_to :user, required: true

  validates_with(SensorValidator)


end
