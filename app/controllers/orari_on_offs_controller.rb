class OrariOnOffsController < ApplicationController
  before_action :set_orari, only: [:edit, :update]

  def index
    @orari = OrariOnOff.all
  end

  def new
    @orario = OrariOnOff.new
    @days = %w[Lunedì Martedì Mercoledì Giovedì Venerdì Sabato Domenica]
  end

  # POST /rooms
  def create
    @orario = OrariOnOff.parse(params)
    respond_to do |format|
      if @orario.nil?
        format.html { redirect_to new_room_orari_on_off_path(params[:room_id]), notice: 'Errore nell\'inserimento degli orari, controlla meglio e riprova'   }
        format.json { render json: @orario.errors, status: :unprocessable_entity }
      else
        #ciclare il salvataggio in una transaction ActiveRecord::Base.transaction do
        if @orario.save
          format.html { redirect_to rooms_path , notice: 'Orari salvati' }
          format.json { render :index, status: :created, location: @orario }
        end
      end
    end
  end

  #GET /rooms/:id/edit
  def edit
  end

  # PATCH/PUT /rooms/:id
  def update
    respond_to do |format|
      if @orario.update(room_params)
        format.html { redirect_to room_orari_on_offs_path, notice: 'Stanza modificata con successo' }
        format.json { render :index, status: :ok, location: @orario }
      else
        format.html { render :edit }
        format.json { render json: @orario.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_orario
    @orario = OrariOnOff.find(params[:id])
  end

end
