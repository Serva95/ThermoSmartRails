class RoomsController < ApplicationController
  before_action :set_room, only: [:destroy, :edit, :update]
  before_action :set_room_id, only: [:manual_active, :manual_inactive, :manual_off]

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
    if @room.sensor_id.nil? || @room.sensor_id.empty?
      @room.sensor_id = nil
    end
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
    if @room.sensor_id.nil?
      @sensors = Sensor.find_not_associated_sensors
    else
      @sensors = Sensor.not_ass_sensors_plus_actual(@room.sensor_id)
    end
  end

  # PATCH/PUT /rooms/:id
  def update
    paramz = room_params
    if room_params[:sensor_id].nil? || room_params[:sensor_id].empty?
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

  # PATCH/PUT /rooms/:id/manual_active
  def manual_active
    params = ActionController::Parameters.new({room: {manual_active: ""}})
    room = room_status_update(params)
    @room.manual_active ? room[:manual_active] = false : room[:manual_active] = true
    respond_to do |format|
      if @room.update(room)
        format.html { redirect_to room_path(@room), notice: 'Cambio di stato effettuato con successo' }
        format.json { render :index, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/:id/manual_inactive
  def manual_inactive
    params = ActionController::Parameters.new({room: {manual_inactive: ""}})
    room = room_status_update(params)
    @room.manual_inactive ? room[:manual_inactive] = false : room[:manual_inactive]=true
    respond_to do |format|
      if @room.update(room)
        format.html { redirect_to room_path(@room), notice: 'Cambio di stato effettuato con successo' }
        format.json { render :index, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/:id/manual_off
  def manual_off
    params = ActionController::Parameters.new({room: {manual_off: ""}})
    room = room_status_update(params)
    @room.manual_off ? room[:manual_off]=false : room[:manual_off]=true
    respond_to do |format|
      if @room.update(room)
        format.html { redirect_to room_path(@room), notice: 'Cambio di stato effettuato con successo' }
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

  def room_status_update(params)
    params.require(:room).permit(:manual_active, :manual_inactive, :manual_off)
  end

  def set_room
    @room = Room.find(params[:id])
  end
  def set_room_id
    @room = Room.find(params[:room_id])
  end

end
