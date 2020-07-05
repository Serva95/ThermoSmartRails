class OrariOnOffsController < ApplicationController
  before_action :set_orari, only: [:edit]

  def index
    @orari = OrariOnOff.where(:room_id => params[:room_id]).order(giorno: :asc).order(fascia: :asc)
    @days = %w[Lunedì Martedì Mercoledì Giovedì Venerdì Sabato Domenica]
  end

  def new
    @orario = OrariOnOff.new
    @days = %w[Lunedì Martedì Mercoledì Giovedì Venerdì Sabato Domenica]
  end

  # POST /rooms/:room_id/orari_on_offs
  def create
    @orario = OrariOnOff.parse(params[:orari_on_off])
    respond_to do |format|
      if @orario.nil?
        format.html { redirect_to new_room_orari_on_off_path(params[:room_id]), notice: 'Errore nell\'inserimento degli orari, controlla meglio e riprova'   }
        format.json { render json: @orario.errors, status: :unprocessable_entity }
      else
        #ciclare il salvataggio in una transaction ActiveRecord::Base.transaction do
        if OrariOnOff.save_all(@orario, params[:room_id])
          format.html { redirect_to room_orari_on_offs_path(params[:room_id]) , notice: 'Orari salvati' }
          format.json { render :index, status: :created, location: @orario }
        end
      end
    end
  end

  #GET /rooms/:room_id/orari_on_offs/edit
  def edit
    if params[:error] == "true"
      @error = true
    end
    @days = %w[Lunedì Martedì Mercoledì Giovedì Venerdì Sabato Domenica]
  end

  # PATCH/PUT /rooms/:room_id/orari_on_offs/edit
  # <ActionController::Parameters {"_method"=>"put", "authenticity_token"=>".....", "id_1"=>"13", "orari_on_off"=>{"timeonuno"=>"06:30:00", "timeoffuno"=>"08:00:00", "timeondue"=>"11:00:00", "timeoffdue"=>"11:00:00", "timeontre"=>"", "timeofftre"=>""}, "id_2"=>"14", "commit"=>"Inserisci gli orari", "controller"=>"orari_on_offs", "action"=>"update", "room_id"=>"1"} permitted: false>
  def update
    ok = OrariOnOff.parse_edit(params)
    respond_to do |format|
      if ok
        format.html { redirect_to room_orari_on_offs_path(params[:room_id]), notice: 'Orario aggiornati con successo' }
        format.json { render :index, status: :ok, location: @orario }
      else
        format.html { redirect_to room_orari_on_off_edit_path(params[:room_id], giorno: params[:giorno], error: true) }
        format.json { render json: @orario.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_orari
    @orari = OrariOnOff.find_orari(params[:room_id], params[:giorno])
  end

end
