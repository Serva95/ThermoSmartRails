class RoomsController < ApplicationController

  def show
    @room = Room.find(params[:id])
  end

  # GET /rooms
  def index
    @rooms = Room.all
  end

end
