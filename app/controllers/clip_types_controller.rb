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
