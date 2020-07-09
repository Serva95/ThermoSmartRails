class ChartsController < ApplicationController

  # POST /updateTemps.json
  def update_temps
    last_read = Temp.update_chart_temp(params[:previous], params[:sensor_id])
    unless last_read.nil?
      @temp = last_read.temp
      @created_at = last_read.created_at.strftime("%T")
    end
  end

  # POST /updateMeds.json
  def update_meds
    @averages = Temp.get_medium_temps(params[:sensor_id], params[:days])
  end
end
