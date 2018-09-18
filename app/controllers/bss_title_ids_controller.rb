class BssTitleIdsController < ApplicationController
  before_action :set_bss_title_id, only: [:show, :edit, :update, :destroy]

  # GET /bss_title_ids
  # GET /bss_title_ids.json
  def index
    @bss_title_ids = BssTitleId.search(params[:search], params[:page])
  end

  # GET /bss_title_ids/1
  # GET /bss_title_ids/1.json
  def show
  end

  # GET /bss_title_ids/new
  def new
    @bss_title_id = BssTitleId.new
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
        								#redirect_to episode_path(@bss_title_id.episode), notice: 'BSS Title ID: ' + @bss_title_id.bss_title_id + ' was successfully updated.' 
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bss_title_id
      @bss_title_id = BssTitleId.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bss_title_id_params
      params.require(:bss_title_id).permit(:bss_title_id, :episode_id, :source)
    end
end
