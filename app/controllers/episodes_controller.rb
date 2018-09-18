class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]

  # GET /episodes
  # GET /episodes.json
  def index
    #@episodes = Episode.all
    respond_to do |format|
      format.html { @episodes = Episode.search_title_and_episode(params[:search], params[:page])}
      format.json { @episodes = Episode.search_title_and_episode(params[:search], params[:page])}
    end
  end

  # GET /episodes/1
  # GET /episodes/1.json
  def show
  end

  # GET /episodes/new
  def new
    @episode = Episode.new
  end

  # GET /episodes/1/edit
  def edit
  	@episode.source = params[:source]
  	@episode.season_choice = params[:season_choice]
  end

  # POST /episodes
  # POST /episodes.json
  def create
    @episode = Episode.new(episode_params)

    respond_to do |format|
      if @episode.save
        format.html { redirect_to @episode, notice: 'Episode was successfully created.' }
        format.json { render :show, status: :created, location: @episode }
      else
        format.html { render :new }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /episodes/1
  # PATCH/PUT /episodes/1.json
  def update
  	respond_to do |format|
      if @episode.update(episode_params)
      	Episode.numericise @episode
      	@episode.save
       	@episode.source = episode_params[:source]
        format.html { 
        							if @episode.source == 'title_show'
        								logger.debug episode_params[:season_choice]
        								redirect_to title_path(@episode.title, season_choice: episode_params[:season_choice]), notice: 'Episode: ' + @episode.episode_title + ' was successfully updated.' 
        							else
	        							redirect_to @episode, notice: 'Episode was successfully updated.'
	        						end
	        					}
        format.json { render :show, status: :ok, location: @episode }
      else
        format.html { render :edit }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /episodes/1
  # DELETE /episodes/1.json
  def destroy
  	title = @episode.title
  	@episode.destroy
    respond_to do |format|
      format.html { 
										if title && params[:source] == 'title_show'
											logger.debug params[:season_choice]
											redirect_to title_path(@episode.title, season_choice: params[:season_choice]), notice: 'Episode: ' + @episode.episode_title + ' was successfully deleted.'  
										else
											redirect_to episodes_url, notice: 'Episode was successfully destroyed.'
										end
									}
      format.json { head :no_content }
    end
  end

  #=================================
  # Muvi2 Additions
  #=================================
  
  # add_bss_title_id 
  def add_bss_title_id
  	@episode = Episode.find(params[:id])
  	@bss_title_id = @episode.bss_title_ids.create(bss_title_id: "")
  	@bss_title_id.source = params[:source]
  	respond_to do |format|
	  	format.html {redirect_to edit_bss_title_id_path(@bss_title_id, :source => params[:source]), notice: 'Add BSS Title ID details'}
	  	format.json {render :show, status: :created, location: @episode}
  	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params.require(:episode).permit(:year, :season, :episode, :title_id, :episode_title, :source, :season_choice)
    end
end
