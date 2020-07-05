class OrariOnOff < ApplicationRecord
  belongs_to :room

  def self.parse(params)
    orari = []
    giorno = []
    params.each do |key, value|
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

  def self.parse_edit(params)
    error = false
    delete = Array.new(2, false)
    orari = params[:orari_on_off]
    orario_uno = OrariOnOff.find(params[:id_1])
    # verifico che orario on 1 sia dopo orario off 1
    if orari[:timeonuno] >= orari[:timeoffuno]
      error = true
    end
    orario_uno.orario_accensione = orari[:timeonuno]
    orario_uno.orario_spegnimento = orari[:timeoffuno]

    # caso possibile di insert new per orario 2 e 3
    if params[:id_2].nil?
      # controllo che ci siano i dati sennò salto - non è insert new
      unless orari[:timeondue].blank? && orari[:timeoffdue].blank?
        # verifico che orario on 2 sia dopo orario off 2 e che orario on 2 sia dopo orario off 1
        if orari[:timeondue] >= orari[:timeoffdue] || orari[:timeoffuno] >= orari[:timeondue]
          error = true
        end
        # creo nuovo orario 2
        orario_due = OrariOnOff.new
        orario_due.room_id = orario_uno.room_id
        orario_due.giorno = orario_uno.giorno
        orario_due.fascia = 1
        orario_due.orario_accensione = orari[:timeondue]
        orario_due.orario_spegnimento = orari[:timeoffdue]

        # controllo che ci siano i dati sennò salto
        unless orari[:timeontre].blank? && orari[:timeofftre].blank?
          # verifico che orario on 3 sia dopo orario off 3 e che orario on 3 sia dopo orario off 2
          if orari[:timeontre] >= orari[:timeofftre] || orari[:timeoffdue] >= orari[:timeontre]
            error = true
          end
          # creo nuovo orario 3
          orario_tre = OrariOnOff.new
          orario_tre.room_id = orario_uno.room_id
          orario_tre.giorno = orario_uno.giorno
          orario_tre.fascia = 2
          orario_tre.orario_accensione = orari[:timeontre]
          orario_tre.orario_spegnimento = orari[:timeofftre]
        end
      end
    # se c'è id 2 è update o delete del vecchio
    else
      orario_due = OrariOnOff.find(params[:id_2])
      # se ci siono i dati è update sennò è delete
      if orari[:timeondue].blank? && orari[:timeoffdue].blank?
        delete[0] = true
      else
        # verifico che orario on 2 sia dopo orario off 2 e che orario on 2 sia dopo orario off 1
        if orari[:timeondue] >= orari[:timeoffdue] || orari[:timeoffuno] >= orari[:timeondue]
          error = true
        end
        # update orario 2
        orario_due.orario_accensione = orari[:timeondue]
        orario_due.orario_spegnimento = orari[:timeoffdue]
      end
      if params[:id_3].nil?
        # controllo che ci siano i dati sennò salto
        unless orari[:timeontre].blank? && orari[:timeofftre].blank?
          # verifico che orario on 3 sia dopo orario off 3 e che orario on 3 sia dopo orario off 2
          if orari[:timeontre] >= orari[:timeofftre] || orari[:timeoffdue] >= orari[:timeontre]
            error = true
          end
          # creo nuovo orario 3
          orario_tre = OrariOnOff.new
          orario_tre.room_id = orario_uno.room_id
          orario_tre.giorno = orario_uno.giorno
          orario_tre.fascia = 2
          orario_tre.orario_accensione = orari[:timeontre]
          orario_tre.orario_spegnimento = orari[:timeofftre]
        end
      end
    end

    # se c'è id 3 è update o delete del vecchio - insert new gestito sopra
    unless params[:id_3].nil?
      orario_tre = OrariOnOff.find(params[:id_3])
      # se ci siono i dati è update sennò è delete
      if (orari[:timeontre].blank? && orari[:timeofftre].blank?) || (orari[:timeondue].blank? && orari[:timeoffdue].blank?)
        delete[1] = true
      else
        # verifico che orario on 3 sia dopo orario off 3 e che orario on 3 sia dopo orario off 2
        if orari[:timeontre] >= orari[:timeofftre] || orari[:timeoffdue] >= orari[:timeontre]
          error = true
        end
        # update orario 3
        orario_tre.orario_accensione = orari[:timeontre]
        orario_tre.orario_spegnimento = orari[:timeofftre]
      end
    end

    # se ci sono errori non salvo nulla e mostro l'errore - sennò salvo tutto
    if error
      return false
    else
      ActiveRecord::Base.transaction do
        orario_uno.save

        if delete[0]
          orario_due.delete
        else
          unless orario_due.nil?
            orario_due.save
          end
        end
        if delete[1]
          orario_tre.delete
        elsif !delete[0]
          unless orario_tre.nil?
            orario_tre.save
          end
        end
      end

      after_commit do
        true
      end
    end
  end

end
