class Room < ApplicationRecord
  has_one :sensor
  has_many :orari_on_offs, dependent: :destroy
end
