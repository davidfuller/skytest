class ClipTypesController < ApplicationController
  before_action :set_clip_type, only: [:show, :edit, :update, :destroy]

  # GET /clip_types
  # GET /clip_types.json
  def index
    @clip_types = ClipType.all
  end

  # GET /clip_types/1
  # GET /clip_types/1.json
  def show
    @device_types = DeviceType.all
    @channels = Channel.all
  end

  # GET /clip_types/new
  def new
    @clip_type = ClipType.new
  end

  # GET /clip_types/1/edit
  def edit
  end

  # POST /clip_types
  # POST /clip_types.json
  def create
    @clip_type = ClipType.new(clip_type_params)

    respond_to do |format|
      if @clip_type.save
        format.html { redirect_to clip_types_path, notice: 'Clip type was successfully created.' }
        format.json { render :show, status: :created, location: @clip_type }
      else
        format.html { render :new }
        format.json { render json: @clip_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clip_types/1
  # PATCH/PUT /clip_types/1.json
  def update
    respond_to do |format|
      if @clip_type.update(clip_type_params)
        format.html { redirect_to clip_types_path, notice: 'Clip type was successfully updated.' }
        format.json { render :show, status: :ok, location: @clip_type }
      else
        format.html { render :edit }
        format.json { render json: @clip_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clip_types/1
  # DELETE /clip_types/1.json
  def destroy
    @clip_type.destroy
    respond_to do |format|
      format.html { redirect_to clip_types_url, notice: 'Clip type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #=================================
  # Muvi2 Additions
  #=================================
  
  # remove device_type
  def remove_device_type
    device = DeviceType.find(params[:device_id])
    @clip_type = ClipType.find(params[:id])
  	@clip_type.device_types.delete(device)
  	respond_to do |format|
	  	format.html {redirect_to @clip_type, notice: 'Device Type removed'}
	  	format.json {render :show, status: :removed, location: @clip_type}
  	end
  end

  def add_device_type
    device = DeviceType.find(params[:device_id])
    @clip_type = ClipType.find(params[:id])
    if @clip_type.device_already_present(params[:device_id])
      respond_to do |format|
        format.html {redirect_to @clip_type, notice: 'Device Type already present'}
        format.json {render :show, status: :present, location: @clip_type}
      end
    else
      @clip_type.clip_type_device_joins.create(device_type: device)
      respond_to do |format|
        format.html {redirect_to @clip_type, notice: 'Device Type added'}
        format.json {render :show, status: :created, location: @clip_type}
      end
    end
  end

  def add_tx_channel
    @clip_type = ClipType.find(params[:id])
    respond_to do |format|
	  	format.html {redirect_to @clip_type, notice: 'Device Type removed'}
	  	format.json {render :show, status: :removed, location: @clip_type}
  	end
  end

  def add_promo_channel
    @clip_type = ClipType.find(params[:id])
    respond_to do |format|
	  	format.html {redirect_to @clip_type, notice: 'Device Type removed'}
	  	format.json {render :show, status: :removed, location: @clip_type}
  	end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clip_type
      @clip_type = ClipType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clip_type_params
      params.require(:clip_type).permit(:name, :description, :default_duration, :default_has_audio)
    end
end
