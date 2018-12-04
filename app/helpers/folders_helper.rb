module FoldersHelper

  def remove_clip_type(folder, clip_type, params)
    remove_clip_type_folder_path(my_params_folder_clip_type(folder, clip_type, params))
  end
  
  def add_clip_type(folder, clip_type, params)
    add_clip_type_folder_path(my_params_folder_clip_type(folder, clip_type, params))
  end

  def my_params_folder_clip_type(folder, clip_type, params)
    {id: folder, clip_type_id: clip_type, clip_type_data_show: params[:clip_type_data_show], search: params[:search], 
                  clip_type_add_show: params[:clip_type_add_show]}
  end

end
