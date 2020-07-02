class TempsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!, only: [:create]

  # GET /temps
  def index
    @rooms = Room.all
  end

  # GET  /rooms/:room_id/temps
  def room_temps
    ActiveRecord::Base.transaction do
      @temps = Temp.find_room_temps(params[:sensor_id])
      @meds = Temp.get_medium_temps(params[:sensor_id], 7)
      @last = Temp.read_last(params[:sensor_id])
    end
  end

  def create
    @temp = Temp.new(temp_params)
    respond_to do |format|
      if params[:sensor_id] == @temp.sensor_id && @temp.save
        format.html { head :created }
        #format.html { render plain: "OK" }
        #format.json { render :index, status: :created, location: @temp }
      else
        format.html { redirect_to root_path }
        #format.json { render json: @temp.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def temp_params
    params.require(:temp).permit(:temp, :hum, :sensor_id)
  end

end
