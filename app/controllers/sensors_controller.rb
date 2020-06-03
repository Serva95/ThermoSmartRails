class SensorsController < ApplicationController

  # GET /sensors
  def index
    @sensors = Sensor.all
  end

end
