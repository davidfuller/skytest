class ChannelTypesController < ApplicationController
  before_action :set_channel_type, only: [:show, :edit, :update, :destroy]

  # GET /channel_types
  # GET /channel_types.json
  def index
    @channel_types = ChannelType.all
  end

  # GET /channel_types/1
  # GET /channel_types/1.json
  def show
  end

  # GET /channel_types/new
  def new
    @channel_type = ChannelType.new
  end

  # GET /channel_types/1/edit
  def edit
  end

  # POST /channel_types
  # POST /channel_types.json
  def create
    @channel_type = ChannelType.new(channel_type_params)

    respond_to do |format|
      if @channel_type.save
        format.html { redirect_to channel_types_path, notice: 'Channel type was successfully created.' }
        format.json { render :show, status: :created, location: @channel_type }
      else
        format.html { render :new }
        format.json { render json: @channel_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channel_types/1
  # PATCH/PUT /channel_types/1.json
  def update
    respond_to do |format|
      if @channel_type.update(channel_type_params)
        format.html { redirect_to channel_types_path, notice: 'Channel type was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel_type }
      else
        format.html { render :edit }
        format.json { render json: @channel_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channel_types/1
  # DELETE /channel_types/1.json
  def destroy
    @channel_type.destroy
    respond_to do |format|
      format.html { redirect_to channel_types_url, notice: 'Channel type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel_type
      @channel_type = ChannelType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_type_params
      params.require(:channel_type).permit(:name, :tx, :has_promotion)
    end
end
