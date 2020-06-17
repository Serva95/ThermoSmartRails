class OrariOnOff < ApplicationRecord
  belongs_to :room

  def self.parse(params)
    orari = []
    giorno = []
    actual = 0
    previous_value = nil
    params.each do |key, value|
      if !value.empty? && key[0..3] == "time"
        case key[-1, 1].to_i
        when 0
          #creare un meotodo con sta roba?????
          if previous_value.nil?
            previous_value = value
          else
            if previous_value >= value
              orari = nil
              break
            end
            chop = key.dup
            chop.chop!
            if chop == "timeoffuno" || chop == "timeoffdue" || chop == "timeofftre"
              giorno << previous_value
              giorno << value
            end
            previous_value = nil
          end
        when 1
          if actual != 1
            orari << giorno
            giorno = []
            previous_value = nil
            actual = 1
          end

          if previous_value.nil?
            previous_value = value
          else
            if previous_value >= value
              orari = nil
              break
            end
            chop = key.dup
            chop.chop!
            if chop == "timeoffuno" || chop == "timeoffdue" || chop == "timeofftre"
              giorno << previous_value
              giorno << value
            end
            previous_value = nil
          end
        when 2
          if actual != 2
            orari << giorno
            giorno = []
            previous_value = nil
            actual = 2
          end

          if previous_value.nil?
            previous_value = value
          else
            if previous_value >= value
              orari = nil
              break
            end
            chop = key.dup
            chop.chop!
            if chop == "timeoffuno" || chop == "timeoffdue" || chop == "timeofftre"
              giorno << previous_value
              giorno << value
            end
            previous_value = nil
          end
        when 3
          if actual != 3
            orari << giorno
            giorno = []
            previous_value = nil
            actual = 3
          end

          if previous_value.nil?
            previous_value = value
          else
            if previous_value >= value
              orari = nil
              break
            end
            chop = key.dup
            chop.chop!
            if chop == "timeoffuno" || chop == "timeoffdue" || chop == "timeofftre"
              giorno << previous_value
              giorno << value
            end
            previous_value = nil
          end
        when 4
          if actual != 4
            orari << giorno
            giorno = []
            previous_value = nil
            actual = 4
          end

          if previous_value.nil?
            previous_value = value
          else
            if previous_value >= value
              orari = nil
              break
            end
            chop = key.dup
            chop.chop!
            if chop == "timeoffuno" || chop == "timeoffdue" || chop == "timeofftre"
              giorno << previous_value
              giorno << value
            end
            previous_value = nil
          end
        when 5
          if actual != 5
            orari << giorno
            giorno = []
            previous_value = nil
            actual = 5
          end

          if previous_value.nil?
            previous_value = value
          else
            if previous_value >= value
              orari = nil
              break
            end
            chop = key.dup
            chop.chop!
            if chop == "timeoffuno" || chop == "timeoffdue" || chop == "timeofftre"
              giorno << previous_value
              giorno << value
            end
            previous_value = nil
          end
        when 6
          if actual != 6
            orari << giorno
            giorno = []
            previous_value = nil
            actual = 6
          end

          if previous_value.nil?
            previous_value = value
          else
            if previous_value >= value
              orari = nil
              break
            end
            chop = key.dup
            chop.chop!
            if chop == "timeoffuno" || chop == "timeoffdue" || chop == "timeofftre"
              giorno << previous_value
              giorno << value
            end
            previous_value = nil
          end
        else
        end
      end
    end
    unless orari.nil?
      orari << giorno
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

end
