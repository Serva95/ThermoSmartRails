class TempsController < ApplicationController

  # GET /temps
  def index
    @sensors = Temp.all
  end

  def show
    @temp = Temp.find(params[:id])
  end

end
