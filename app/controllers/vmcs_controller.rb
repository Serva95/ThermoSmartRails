class VmcsController < ApplicationController
  before_action :set_vmc, only: [:destroy, :edit, :update]
  before_action :set_vmc_id, only: [:on, :off]

  # GET /vmcs
  def index
    @vmcs = Vmc.all
  end

  # GET /vmcs/new
  def new
    @vmc = Vmc.new
  end

  # POST /vmcs
  def create
    @vmc = Vmc.new(vmc_params)
    respond_to do |format|
      if @vmc.save
        format.html { redirect_to vmcs_path , notice: 'VMC creata' }
        format.json { render :index, status: :created, location: @vmc }
      else
        format.html { render :new }
        format.json { render json: @vmc.errors, status: :unprocessable_entity }
      end
    end
  end

  #GET /vmcs/:id/edit
  def edit
  end

  # PATCH/PUT /vmcs/:id
  def update
    respond_to do |format|
      if @vmc.update(vmc_params)
        format.html { redirect_to vmcs_path, notice: 'VMC modificata con successo' }
        format.json { render :index, status: :ok, location: @vmc }
      else
        format.html { render :edit }
        format.json { render json: @vmc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vmcs/:id
  def destroy
    respond_to do |format|
      if @vmc.destroy
        format.html { redirect_to vmcs_path, notice: 'VMC eliminata con successo' }
        format.json { render :index, status: :ok, location: @vmc }
      else
        format.html { redirect_to vmcs_path, notice: 'Errore nell\'eliminazione della VMC' }
        format.json { render json: @vmc.errors, status: :internal_server_error }
      end
    end
  end

  # PATCH/PUT /vmcs/:id/on
  def on
    params = ActionController::Parameters.new({vmc: {impostazione_funzione: ""}})
    vmc = vmc_status_update(params)
    @vmc.impostazione_funzione ? vmc[:impostazione_funzione] = false : vmc[:impostazione_funzione] = true
    respond_to do |format|
      if @vmc.update(vmc)
        format.html { redirect_to vmcs_path, notice: 'Cambio di stato effettuato con successo' }
        format.json { render :index, status: :ok, location: @vmc }
      else
        format.html { render :edit }
        format.json { render json: @vmc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vmcs/:id/off
  def off
    params = ActionController::Parameters.new({vmc: {impostazione_funzione: ""}})
    vmc = vmc_status_update(params)
    @vmc.impostazione_funzione ? vmc[:impostazione_funzione] = false : vmc[:impostazione_funzione] = true
    respond_to do |format|
      if @vmc.update(vmc)
        format.html { redirect_to vmcs_path, notice: 'Cambio di stato effettuato con successo' }
        format.json { render :index, status: :ok, location: @vmc }
      else
        format.html { render :edit }
        format.json { render json: @vmc.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def vmc_params
    params.require(:vmc).permit(:id, :programmed_on_time, :programmed_off_time)
  end

  def vmc_status_update(params)
    params.require(:vmc).permit(:impostazione_funzione)
  end

  def set_vmc
    @vmc = Vmc.find(params[:id])
  end

  def set_vmc_id
    @vmc = Vmc.find(params[:vmc_id])
  end
end
