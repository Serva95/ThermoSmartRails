class OrariOnOff < ApplicationRecord
  belongs_to :room

  def self.parse(params)
    orari = []
    giorno = []
    params.each do |key, value|
      #creare un meotodo con sta roba?????
      if value[:timeonuno] >= value[:timeoffuno]
        orari = nil
        break
      else
        giorno << value[:timeonuno]
        giorno << value[:timeoffuno]
      end
      unless value[:timeondue].blank?
        if value[:timeoffuno] >= value[:timeondue] || value[:timeondue] >= value[:timeoffdue]
          orari = nil
          break
        else
          giorno << value[:timeondue]
          giorno << value[:timeoffdue]
        end
        unless value[:timeontre].blank?
          if value[:timeoffdue] >= value[:timeontre] || value[:timeontre] >= value[:timeofftre]
            orari = nil
            break
          else
            giorno << value[:timeontre]
            giorno << value[:timeofftre]
          end
        end
      end
      orari << giorno
      giorno = []
    end
    return orari
  end

  def self.save_all(orari, room_id)
    fascia = 0
    ActiveRecord::Base.transaction do
      orari.each_with_index { |value, giorno|
        value.each_slice(2) do |orari_fascia|
          orari_to_db = OrariOnOff.new
          orari_to_db.room_id = room_id
          orari_to_db.giorno = giorno
          orari_to_db.fascia = fascia
          orari_to_db.orario_accensione = orari_fascia[0]
          orari_to_db.orario_spegnimento = orari_fascia[1]
          fascia += 1
          orari_to_db.save
        end
        fascia = 0
      }
      after_commit do
        return true
      end
    end
  end

  def self.find_orari(room_id, giorno)
    OrariOnOff.where(:room_id => room_id, :giorno => giorno)
  end

end
