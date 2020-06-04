class SensorsController < ApplicationController
  before_action :set_sensor, only: [:destroy, :update]

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
    @sensor = Sensor.new
    respond_to do |format|
      if @sensor.save!
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

  end

  # PATCH/PUT /sensors/:id
  def update

  end

  private

  def sensor_params
    params[:id] = params[:vote].to_i
    params.require(:sensor).permit(:id, :nome, :location)
  end

  def set_sensor
    @sensor = Sensor.find(params[:id])
  end

end
