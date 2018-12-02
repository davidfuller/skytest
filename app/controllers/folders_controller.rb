class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  # GET /folders
  # GET /folders.json
  def index
    @folders = Folder.minus_none
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @clip_types = ClipType.search(params[:search])
    @folder.view_options = params
  end


  # GET /folders/new
  def new
    @clip_types = ClipType.search(params[:search])
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit
    @clip_types = ClipType.search(params[:search])
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.html { redirect_to folders_path, notice: 'Folder was successfully created.' }
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to folders_path, notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to folders_url, notice: 'Folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Muvi2 added stuff================= 
  def duplicate
    old_record = Folder.find(params[:id])
    @folder = old_record.dup
    @folder.name = old_record.name + ' copy'
    respond_to do |format|
      if @folder.save
        format.html {redirect_to edit_folder_path(@folder)}
        format.json {render :show, status: :ok, location: @folder}
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def remove_clip_type
    clip_type = ClipType.find(params[:clip_type_id])
    @folder = Folder.find(params[:id])
  	@folder.clip_types.delete(clip_type)
  	respond_to do |format|
	  	format.html {redirect_to folder_path(@folder, show_details(params)), notice: clip_type.name + ' removed'}
	  	format.json {render :show, status: :removed, location: @folder}
  	end
  end
  
  def add_clip_type
    clip_type = ClipType.find(params[:clip_type_id])
    @folder = Folder.find(params[:id])
    if @folder.clip_type_already_present(params[:clip_type_id])
      notice = clip_type.name + ' already present'
      json_notice = :present
    else
      @folder.clip_type_folder_joins.create(clip_type: clip_type)
      notice = clip_type.name + ' added'
      json_notice = :created
    end
    respond_to do |format|
      format.html {redirect_to folder_path(@folder, show_details(params)), notice: notice}
      format.json {render :show, status: json_notice, location: @folder}
    end
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :note, :clipstore, :proxy, :jpeg, :clip_limit, :overflow_id, :year)
    end
    
    def show_details(the_params)
      my_params = {}
      my_params[:search] = the_params[:search]
      my_params[:clip_type_data_show] = true
      my_params[:clip_type_add_show] = true
      my_params
    end
    
end
