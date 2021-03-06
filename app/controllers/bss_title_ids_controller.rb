class BssTitleIdsController < ApplicationController
  before_action :set_bss_title_id, only: [:show, :edit, :update, :destroy]

  # GET /bss_title_ids
  # GET /bss_title_ids.json
  def index
    respond_to do |format|
      format.html { @bss_title_ids = BssTitleId.search_title_and_bss_id_paged(params[:search], params[:page])}
      format.json { @bss_title_ids = BssTitleId.search_bss_title_id(params[:search])}
    end
  end

  # GET /bss_title_ids/1
  # GET /bss_title_ids/1.json
  def show
    @channels = Channel.bss_title_id_search(params[:search])
    @clips = Clip.search(params[:search_clip])
    @bss_title_id.view_options = params
    @search_clip = params[:clip] == 'clip'
    params[:source] = :bss_show
  end

  # GET /bss_title_ids/new
  def new
    @bss_title_id = BssTitleId.new
    @bss_title_id.bss_title_id = BssTitleId.create_dummy_id
    if params[:episode]
      @bss_title_id.episode_id = params[:episode]
    end
    if params[:source]
      @bss_title_id.source = params[:source]
    end
  end

  # GET /bss_title_ids/1/edit
  def edit
    @bss_title_id.source = params[:source]
  end

  # POST /bss_title_ids
  # POST /bss_title_ids.json
  def create
    @bss_title_id = BssTitleId.new(bss_title_id_params)

    respond_to do |format|
      if @bss_title_id.save
        format.html { redirect_to @bss_title_id, notice: 'Bss title was successfully created.' }
        format.json { render :show, status: :created, location: @bss_title_id }
      else
        format.html { render :new }
        format.json { render json: @bss_title_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bss_title_ids/1
  # PATCH/PUT /bss_title_ids/1.json
  def update
    respond_to do |format|
      if @bss_title_id.update(bss_title_id_params)

        @bss_title_id.source = bss_title_id_params[:source]
        format.html { 
                      if @bss_title_id.source == 'episode_show'
                        redirect_to title_path(@bss_title_id.episode.title), notice: 'BSS Title ID: ' + @bss_title_id.bss_title_id + ' was successfully updated.' 
                      elsif @bss_title_id.source == 'bss_index'
                        redirect_to bss_title_ids_path, notice: 'BSS Title ID: ' + @bss_title_id.bss_title_id + ' was successfully updated.' 
        							else
	        							redirect_to @bss_title_id, notice: 'BSS Title ID was successfully updated.'
	        						end
	        					}
        format.json { render :show, status: :ok, location: @bss_title_id }
      else
        format.html { render :edit }
        format.json { render json: @bss_title_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bss_title_ids/1
  # DELETE /bss_title_ids/1.json
  def destroy
    episode = @bss_title_id.episode
    @bss_title_id.destroy
    respond_to do |format|
      format.html { 
                    if episode && params[:source] == 'episode_show'
                      redirect_to title_path(@bss_title_id.episode.title), notice: 'BSS Title ID: ' + @bss_title_id.bss_title_id + ' was successfully deleted.' 
                    else
                      redirect_to bss_title_ids_url, notice: 'BSS Title ID was successfully destroyed.' 
                    end
                  }
      format.json { head :no_content }
    end
  end

  #=================================
  # Muvi2 Additions
  #=================================
  
  # remove channel
  def remove_channel
    channel = Channel.find(params[:channel_id])
    @bss_title_id = BssTitleId.find(params[:id])
  	@bss_title_id.channels.delete(channel)
  	respond_to do |format|
      format.html {
        if params[:source] == 'episode_show'
          redirect_to episode_path(@bss_title_id.episode, show_details(:channel, params)), notice: 'Channel: ' + channel.name + ' removed'
        else
          redirect_to bss_title_id_path(@bss_title_id, show_details(:channel, params)), notice: 'Channel: ' + channel.name + ' removed'
        end
      }
	  	format.json {render :show, status: :removed, location: @bss_title_id}
  	end
  end

  def add_channel
    channel = Channel.find(params[:channel_id])
    @bss_title_id = BssTitleId.find(params[:id])
    if @bss_title_id.channel_already_present(params[:channel_id])
      notice = 'Channel: ' + channel.name + ' already present'
      json_notice = :present
    else
      @bss_title_id.bss_channel_joins.create(channel: channel)
      notice = 'Channel: ' + channel.name + ' added'
      json_notice = :created
    end
    respond_to do |format|
      format.html {redirect_to bss_title_id_path(@bss_title_id, show_details(:channel, params)), notice: notice}
      format.json {render :show, status: json_notice, location: @bss_title_id}
    end
  end
  
  def remove_clip
    clip = Clip.find(params[:clip_id])
    @bss_title_id = BssTitleId.find(params[:id])
  	@bss_title_id.clips.delete(clip)
  	respond_to do |format|
	  	format.html {redirect_to bss_title_id_path(@bss_title_id, show_details(:clip, params)), notice: 'Clip: ' + clip.name + ' removed'}
	  	format.json {render :show, status: :removed, location: @bss_title_id}
  	end
  end
  
  def add_clip
    clip = Clip.find(params[:clip_id])
    @bss_title_id = BssTitleId.find(params[:id])
    if @bss_title_id.clip_already_present(params[:clip_id])
      notice = 'Clip: ' + clip.name + ' already present'
      json_notice = :present
    else
      @bss_title_id.bss_clip_joins.create(clip: clip)
      notice = 'Clip: ' + clip.name + ' added'
      json_notice = :created
    end
    respond_to do |format|
      format.html {redirect_to bss_title_id_path(@bss_title_id, show_details(:clip, params)), notice: notice}
      format.json {render :show, status: json_notice, location: @bss_title_id}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bss_title_id
      @bss_title_id = BssTitleId.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bss_title_id_params
      params.require(:bss_title_id).permit(:bss_title_id, :episode_id, :source, :channel_id)
    end
    
    def show_details(the_format, the_params)
      my_params = {}
      my_params[:search] = the_params[:search]
      my_params[:search_clip] = the_params[:search_clip]
      if the_format == :channel
        my_params[:channel_data_show] = true
        my_params[:channel_add_show] = true
        my_params[:clip_data_show] = the_params[:clip_data_show]
        my_params[:clip_add_show] = the_params[:clip_add_show]
      elsif the_format == :clip
        my_params[:channel_data_show] = the_params[:channel_data_show]
        my_params[:channel_add_show] = the_params[:channel_add_show]
        my_params[:clip_data_show] = true
        my_params[:clip_add_show] = true
      end
      my_params
    end

end
