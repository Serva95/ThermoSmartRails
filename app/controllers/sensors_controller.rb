class SensorsController < ApplicationController
  before_action :set_sensor, only: [:destroy, :edit, :update]

  # GET /sensors
  def index
    @sensors = Sensor.all
  end

  # GET /sensors/new
  def new
    @sensor = Sensor.new
  end

  # POST /sensors
  def create
    @sensor = Sensor.new(sensor_params)
    respond_to do |format|
      if @sensor.save
        format.html { redirect_to sensors_path , notice: 'Sensore creato' }
        format.json { render :index, status: :created, location: @sensor }
      else
        format.html { render :new }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensors/:id
  def destroy
    respond_to do |format|
      if @sensor.destroy
        format.html { redirect_to sensors_path, notice: 'Sensore eliminato con successo' }
        format.json { render :index, status: :ok, location: @sensor }
      else
        format.html { redirect_to sensors_path, notice: 'Errore nell\'eliminazione del sensore' }
        format.json { render json: @sensor.errors, status: :internal_server_error }
      end
    end
  end

  #GET /sensors/:id/edit
  def edit
  end

  # PATCH/PUT /sensors/:id
  def update
    respond_to do |format|
      if @sensor.update(sensor_params)
        format.html { redirect_to sensors_path, notice: 'Sensore modificato con successo' }
        format.json { render :index, status: :ok, location: @sensor }
      else
        format.html { render :edit }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def sensor_params
    params.require(:sensor).permit(:id, :nome, :location)
  end

  def set_sensor
    @sensor = Sensor.find(params[:id])
  end

end
