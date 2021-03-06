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
    @channels = Channel.bss_title_id_search(params[:search])
    @clip_type.view_options = params
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
	  	format.html {redirect_to clip_type_path(@clip_type, show_details(:device, params)), notice: device_display(device.name) + ' removed'}
	  	format.json {render :show, status: :removed, location: @clip_type}
  	end
  end

  def add_device_type
    device = DeviceType.find(params[:device_id])
    @clip_type = ClipType.find(params[:id])
    if @clip_type.device_already_present(params[:device_id])
      notice = device_display(device.name) + ' already present'
      json_notice = :present
    else
      @clip_type.clip_type_device_joins.create(device_type: device)
      notice = device_display(device.name) + ' added'
      json_notice = :created
    end
    respond_to do |format|
      format.html {redirect_to clip_type_path(@clip_type, show_details(:device, params)), notice: notice}
      format.json {render :show, status: json_notice, location: @clip_type}
    end
  end
  
  def remove_tx_channel
    notice = remove_channel(:tx)
  	respond_to do |format|
	  	format.html {redirect_to clip_type_path(@clip_type, show_details(:tx, params)), notice: notice}
	  	format.json {render :show, status: :removed, location: @clip_type}
  	end
  end
  def remove_promo_channel
    notice = remove_channel(:promo)
  	respond_to do |format|
	  	format.html {redirect_to clip_type_path(@clip_type, show_details(:promo, params)), notice: notice}
	  	format.json {render :show, status: :removed, location: @clip_type}
  	end
  end

  def add_tx_channel
    add_channel(:tx)
  end

  def add_promo_channel
    add_channel(:promo)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clip_type
      @clip_type = ClipType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clip_type_params
      params.require(:clip_type).permit(:name, :description, :default_duration, :default_has_audio, :device_data_show, :clip_code)
    end

    def add_channel(tx)
      @clip_type = ClipType.find(params[:id])
      channel= Channel.find(params[:channel_id])
      if @clip_type.channel_already_present(params[:channel_id], tx == :tx)
        notice = channel_display(tx, channel.name) + " already present"
        json_notice = :present
      else
        @clip_type.clip_type_channel_joins.create(channel: channel, tx: tx == :tx)
        notice = channel_display(tx, channel.name) + " added"
        json_notice = :created
      end
      respond_to do |format|
        format.html {redirect_to clip_type_path(@clip_type, show_details(tx, params)), notice: notice}
        format.json {render :show, status: json_notice, location: @clip_type}
      end
    end

    def remove_channel(tx)
      channel = Channel.find(params[:channel_id])
      @clip_type = ClipType.find(params[:id])
      num = @clip_type.delete_channel(channel, tx == :tx)
      if num > 0 then
        notice = channel_display(tx, channel.name) + ' removed'
      else
        notice = channel_display(tx, channel.name) + ' not found'
      end
    end

    def channel_display(tx, name)
      (tx == :tx ? "TX " : "Promo ") + "Channel: " + name
    end

    def device_display(name)
      'Device Type: ' + name
    end

    def show_details(the_format, the_params)
      my_params = {}
      my_params[:search] = the_params[:search]
      if the_format == :tx
        my_params[:tx_data_show] = true
        my_params[:promo_data_show] = the_params[:promo_data_show]
        my_params[:channel_add_show] = true
        my_params[:device_data_show] = the_params[:device_data_show]
        my_params[:device_add_show] = the_params[:device_add_show]
      elsif the_format == :promo
        my_params[:tx_data_show] = the_params[:tx_data_show]
        my_params[:promo_data_show] = true
        my_params[:channel_add_show] = true
        my_params[:device_data_show] = the_params[:device_data_show]
        my_params[:device_add_show] = the_params[:device_add_show]
      elsif the_format == :device
        my_params[:tx_data_show] = the_params[:tx_data_show]
        my_params[:promo_data_show] = the_params[:promo_data_show]
        my_params[:channel_add_show] = the_params[:channel_add_show]
        my_params[:device_data_show] = true
        my_params[:device_add_show] = true
      end
      my_params
    end
end
