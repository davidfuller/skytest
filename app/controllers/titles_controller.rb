class TitlesController < ApplicationController
  before_action :set_title, only: [:show, :edit, :update, :destroy]

  # GET /titles
  # GET /titles.json
  def index
    @titles = Title.search(params[:search], params[:page])
  end

  # GET /titles/1
  # GET /titles/1.json
  def show
  	@season_list = @title.season_list
  	@episode_list = @title.episodes_for_season(params[:season_choice]||"All")
  	if @episode_list.count == 0
  		params[:season_choice] = "All"
			@episode_list = @title.episodes_for_season(params[:season_choice]||"All")
		end
  	logger.debug @episode_list
  end

  # GET /titles/new
  def new
    @title = Title.new
  end

  # GET /titles/1/edit
  def edit
  end

  # POST /titles
  # POST /titles.json
  def create
    @title = Title.new(title_params)
    
    respond_to do |format|
      if @title.save
        format.html { redirect_to titles_url(search: @title.title), notice: 'Title was successfully created.' }
        format.json { render :show, status: :created, location: @title }
      else
        format.html { render :new }
        format.json { render json: @title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /titles/1
  # PATCH/PUT /titles/1.json
  def update
    respond_to do |format|
      if @title.update(title_params)
        format.html { redirect_to titles_url(search: @title.title), notice: 'Title was successfully updated.' }
        format.json { render :show, status: :ok, location: @title }
      else
        format.html { render :edit }
        format.json { render json: @title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /titles/1
  # DELETE /titles/1.json
  def destroy
    @title.destroy
    respond_to do |format|
      format.html { redirect_to titles_url, alert: 'Title: ' + @title.title + ' was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
  #=================================
  # Muvi2 Additions
  #=================================
  
  # add_episode 
  def add_episode
  	@title = Title.find(params[:id])
  	respond_to do |format|
      format.html {redirect_to new_episode_path(title: @title, source: params[:source]), notice: 'Add Episode details'}
	  	format.json {render :show, status: :created, location: @title}
  	end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_title
      @title = Title.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def title_params
      params.require(:title).permit(:title)
    end
end
