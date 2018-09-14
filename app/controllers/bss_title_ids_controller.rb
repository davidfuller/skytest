class BssTitleIdsController < ApplicationController
  before_action :set_bss_title_id, only: [:show, :edit, :update, :destroy]

  # GET /bss_title_ids
  # GET /bss_title_ids.json
  def index
    @bss_title_ids = BssTitleId.all
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
        format.html { redirect_to @bss_title_id, notice: 'Bss title was successfully updated.' }
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
    @bss_title_id.destroy
    respond_to do |format|
      format.html { redirect_to bss_title_ids_url, notice: 'Bss title was successfully destroyed.' }
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
      params.require(:bss_title_id).permit(:bss_title_id, :episode_id)
    end
end
