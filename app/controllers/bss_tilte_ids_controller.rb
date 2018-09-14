class BssTilteIdsController < ApplicationController
  before_action :set_bss_tilte_id, only: [:show, :edit, :update, :destroy]

  # GET /bss_tilte_ids
  # GET /bss_tilte_ids.json
  def index
    @bss_tilte_ids = BssTilteId.all
  end

  # GET /bss_tilte_ids/1
  # GET /bss_tilte_ids/1.json
  def show
  end

  # GET /bss_tilte_ids/new
  def new
    @bss_tilte_id = BssTilteId.new
  end

  # GET /bss_tilte_ids/1/edit
  def edit
  end

  # POST /bss_tilte_ids
  # POST /bss_tilte_ids.json
  def create
    @bss_tilte_id = BssTilteId.new(bss_tilte_id_params)

    respond_to do |format|
      if @bss_tilte_id.save
        format.html { redirect_to @bss_tilte_id, notice: 'Bss tilte was successfully created.' }
        format.json { render :show, status: :created, location: @bss_tilte_id }
      else
        format.html { render :new }
        format.json { render json: @bss_tilte_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bss_tilte_ids/1
  # PATCH/PUT /bss_tilte_ids/1.json
  def update
    respond_to do |format|
      if @bss_tilte_id.update(bss_tilte_id_params)
        format.html { redirect_to @bss_tilte_id, notice: 'Bss tilte was successfully updated.' }
        format.json { render :show, status: :ok, location: @bss_tilte_id }
      else
        format.html { render :edit }
        format.json { render json: @bss_tilte_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bss_tilte_ids/1
  # DELETE /bss_tilte_ids/1.json
  def destroy
    @bss_tilte_id.destroy
    respond_to do |format|
      format.html { redirect_to bss_tilte_ids_url, notice: 'Bss tilte was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bss_tilte_id
      @bss_tilte_id = BssTilteId.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bss_tilte_id_params
      params.require(:bss_tilte_id).permit(:bss_title_id, :episode_id)
    end
end
