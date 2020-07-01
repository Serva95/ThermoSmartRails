class ChartsController < ApplicationController

  # GET /temps.json
  def index
    last_read = Chart.find_last_temp(params[:previous], params[:room_id])
    unless last_read.nil?
      @temp = last_read.temp
      @created_at = last_read.created_at.strftime("%T")
    end
  end
end
