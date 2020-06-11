class RoomsController < ApplicationController
  before_action :set_room, only: [:destroy, :edit, :update]

  # GET /rooms
  def index
    @rooms = Room.all
  end

  # GET /rooms/:id
  def show
    @room = Room.find(params[:id])
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @days = %w[Lunedì Martedì Mercoledì Giovedì Venerdì Sabato Domenica]
  end

  # POST /rooms
  def create
    @room = Room.new(room_params)
    actual = 0
    previous_value = 0
    params.each do |key, value|
      if !value.empty? && key[0..3] == "time"
        case key[-1, 1].to_i
        when 0
          if previous_value == 0
            previous_value = value
          else

          end
          puts "zero #{key} => #{value}"
        when 1
          puts "uno #{key} => #{value}"
        when 2
          puts "2 #{key} => #{value}"
        when 3
          puts "3 #{key} => #{value}"
        when 4
          puts "4 #{key} => #{value}"
        when 5
          puts "5 #{key} => #{value}"
        when 6
          puts "6 #{key} => #{value}"
        else
        end
      end
    end
    byebug
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
  end

  # PATCH/PUT /rooms/:id
  def update
    respond_to do |format|
      if @room.update(room_params)
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
    params.require(:room).permit(:nome, :max_temp, :min_temp, :absolute_min)
  end

  def set_room
    @room = Room.find(params[:id])
  end

end
