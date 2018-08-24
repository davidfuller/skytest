class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]

  # GET /episodes
  # GET /episodes.json
  def index
    @episodes = Episode.all
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
  	
  	logger.debug "Episode params: #{episode_params[:source]}"
  	logger.debug "Episode data: #{@episode.attributes.inspect}"
    respond_to do |format|
      if @episode.update(episode_params)
       	logger.debug "Post update Episode data: #{@episode.attributes.inspect}"
      	@episode.source = episode_params[:source]
				logger.debug "Post source Episode data: #{@episode.source}"
        format.html { 
        							if @episode.source == 'title_show'
        								redirect_to @episode, notice: 'Episode was successfully updated. :title_show'
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
    @episode.destroy
    respond_to do |format|
      format.html { redirect_to episodes_url, notice: 'Episode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params.require(:episode).permit(:year, :season, :episode, :title_id, :episode_title, :source)
    end
end
