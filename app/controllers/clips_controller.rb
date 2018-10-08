class ClipsController < ApplicationController
  before_action :set_clip, only: [:show, :edit, :update, :destroy]

  # GET /clips
  # GET /clips.json
  def index
    @clips = Clip.all
  end

  # GET /clips/1
  # GET /clips/1.json
  def show
    @device_types = DeviceType.all
    @channels = Channel.bss_title_id_search(params[:search])
    @clip.view_options = params
  end

  # GET /clips/new
  def new
    @clip = Clip.new
  end

  # GET /clips/1/edit
  def edit
  end

  # POST /clips
  # POST /clips.json
  def create
    @clip = Clip.new(clip_params)

    respond_to do |format|
      if @clip.save
        format.html { redirect_to clips_path, notice: 'Clip was successfully created.' }
        format.json { render :show, status: :created, location: @clip }
      else
        format.html { render :new }
        format.json { render json: @clip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clips/1
  # PATCH/PUT /clips/1.json
  def update
    respond_to do |format|
      if @clip.update(clip_params)
        format.html { redirect_to clips_path, notice: 'Clip was successfully updated.' }
        format.json { render :show, status: :ok, location: @clip }
      else
        format.html { render :edit }
        format.json { render json: @clip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clips/1
  # DELETE /clips/1.json
  def destroy
    @clip.destroy
    respond_to do |format|
      format.html { redirect_to clips_url, notice: 'Clip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
  #=================================
  # Muvi2 Additions
  #=================================
  
  # remove device_type
  def remove_device_type
    device = DeviceType.find(params[:device_id])
    @clip = Clip.find(params[:id])
  	@clip.device_types.delete(device)
  	respond_to do |format|
	  	format.html {redirect_to clip_path(@clip, show_details(:device, params)), notice: device_display(device.name) + ' removed'}
	  	format.json {render :show, status: :removed, location: @clip}
  	end
  end

  def add_device_type
    device = DeviceType.find(params[:device_id])
    @clip = Clip.find(params[:id])
    if @clip.device_already_present(params[:device_id])
      notice = device_display(device.name) + ' already present'
      json_notice = :present
    else
      @clip.clip_device_joins.create(device_type: device)
      notice = device_display(device.name) + ' added'
      json_notice = :created
    end
    respond_to do |format|
      format.html {redirect_to clip_path(@clip, show_details(:device, params)), notice: notice}
      format.json {render :show, status: json_notice, location: @clip}
    end
  end
  
  def add_tx_channel
    add_channel(:tx)
  end

  def add_promo_channel
    add_channel(:promo)
  end

  def remove_tx_channel
    notice = remove_channel(:tx)
  	respond_to do |format|
	  	format.html {redirect_to clip_path(@clip, show_details(:tx, params)), notice: notice}
	  	format.json {render :show, status: :removed, location: @clip}
  	end
  end
  def remove_promo_channel
    notice = remove_channel(:promo)
  	respond_to do |format|
	  	format.html {redirect_to clip_path(@clip, show_details(:promo, params)), notice: notice}
	  	format.json {render :show, status: :removed, location: @clip}
  	end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clip
      @clip = Clip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clip_params
      params.require(:clip).permit(:name, :note, :filename, :folder_id, :has_audio, :audio_filename, 
                                      :clip_type_id, :duration, :start_season, :start_episode, :end_season, :end_episode, 
                                      :season_generic, :totally_generic, :first_use, :last_use, :completion, :completion_date_string, :user_id, :status_id)
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
    
    def add_channel(tx)
      @clip = Clip.find(params[:id])
      channel= Channel.find(params[:channel_id])
      if @clip.channel_already_present(params[:channel_id], tx)
        notice = channel_display(tx, channel.name) + " already present"
        json_notice = :present
      else
        @clip.clip_channel_joins.create(channel: channel, tx: tx == :tx)
        notice = channel_display(tx, channel.name) + " added"
        json_notice = :created
      end
      respond_to do |format|
        format.html {redirect_to clip_path(@clip, show_details(tx, params)), notice: notice}
        format.json {render :show, status: json_notice, location: @clip}
      end
    end

    def remove_channel(tx)
      channel = Channel.find(params[:channel_id])
      @clip = Clip.find(params[:id])
      num = @clip.delete_channel(channel, tx)
      if num > 0 then
        notice = channel_display(tx, channel.name) + ' removed'
      else
        notice = channel_display(tx, channel.name) + ' not found'
      end
    end

end
