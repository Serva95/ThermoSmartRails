class OrariOnOffsController < ApplicationController
      before_action :set_orari, only: [:edit, :update]

    def index
      @orari = OrariOnOff.all
    end

    def new
      @orario = OrariOnOff.new
      @days = %w[Lunedì Martedì Mercoledì Giovedì Venerdì Sabato Domenica]
    end

    # POST /rooms
    def create
      @orario = OrariOnOff.new(orari_params)
      actual = 0
      previous_value = 0
      params.each do |key, value|
        if !value.empty? && key[0..3] == "time"
          case key[-1, 1].to_i
            #per ora controlla solo che siano in ordine temporale
          when 0
            #creare un meotodo con sta roba?????
            if previous_value == 0
              previous_value = value
            else
              break if previous_value >= value
              previous_value = value
            end
            #
            puts "zero #{key} => #{value}"
          when 1
            if actual != 1
              actual = 1

            end
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

    #GET /rooms/:id/edit
    def edit
    end

    # PATCH/PUT /rooms/:id
    def update
      respond_to do |format|
        if @orario.update(room_params)
          format.html { redirect_to room_orari_on_offs_path, notice: 'Stanza modificata con successo' }
          format.json { render :index, status: :ok, location: @orario }
        else
          format.html { render :edit }
          format.json { render json: @orario.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def orari_params
      params.require(:room).permit(:nome, :max_temp, :min_temp, :absolute_min)
    end

    def set_orario
      @orario = OrariOnOff.find(params[:id])
    end

end
