class RoomsController < ApplicationController
  before_action :set_room, only: [:destroy, :edit, :update]

  # GET /rooms
  def index
    @rooms = Room.all
  end

  # GET /rooms/:id
  def show
    @room = Room.join_sensor(params[:id])
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @sensors = Sensor.find_not_associated_sensors
  end

  # POST /rooms
  def create
    @room = Room.new(room_params)
    if @room.sensor_id.empty?
      @room.sensor_id = nil
    end
    respond_to do |format|
      if @room.save!
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
    if @room.sensor_id.nil?
      @sensors = Sensor.find_not_associated_sensors
    else
      @sensors = Sensor.not_ass_sensors_plus_actual(@room.sensor_id)
    end
  end

  # PATCH/PUT /rooms/:id
  def update
    paramz = room_params
    if room_params[:sensor_id].empty?
      paramz[:sensor_id] = nil
      @room.sensor_id = nil
    end
    respond_to do |format|
      if @room.update(paramz)
        format.html { redirect_to rooms_path, notice: 'Stanza modificata con successo' }
        format.json { render :index, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def room_params
    params.require(:room).permit(:nome, :max_temp, :min_temp, :absolute_min, :sensor_id)
  end

  def set_room
    @room = Room.find(params[:id])
  end

end
