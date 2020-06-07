class RoomsController < ApplicationController
  before_action :set_room, only: [:destroy, :edit, :update]

  # GET /rooms
  def index
    @rooms = Room.all
  end

  # GET /rooms/:id
  def show
    @room = Room.find(params[:id])
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # POST /rooms
  def create
    @room = Room.new(sensor_params)
    respond_to do |format|
      if @room.save
        format.html { redirect_to rooms_path , notice: 'Stanza creata' }
        format.json { render :index, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/:id
  def destroy
    respond_to do |format|
      if @room.destroy
        format.html { redirect_to rooms_path, notice: 'Stanza eliminata con successo' }
        format.json { render :index, status: :ok, location: @room }
      else
        format.html { redirect_to rooms_path, notice: 'Errore nell\'eliminazione della stanza' }
        format.json { render json: @room.errors, status: :internal_server_error }
      end
    end
  end

  #GET /rooms/:id/edit
  def edit
  end

  # PATCH/PUT /rooms/:id
  def update
    respond_to do |format|
      if @room.update(sensor_params)
        format.html { redirect_to rooms_path, notice: 'Sensore modificato con successo' }
        format.json { render :index, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def room_params
    params.require(:room).permit(:id, :nome, :max_temp, :min_temp, :absolute_min, :sensor_id)
  end

  def set_room
    @room = Room.find(params[:id])
  end

end
