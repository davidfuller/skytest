module BssTitleIdsHelper

  def remove_channel_bss(bss, channel, params)
    my_params = my_params_bss(bss, params)
    my_params[:channel_id] = channel
    remove_channel_bss_title_id_path(my_params)
  end
  
  def remove_clip_bss(bss, clip, params)
    my_params = my_params_bss(bss, params)
    my_params[:clip_id] = clip
    remove_clip_bss_title_id_path(my_params)
  end
  
  
  def add_channel_bss(bss, channel, params)
    my_params = my_params_bss(bss, params)
    my_params[:channel_id] = channel
    add_channel_bss_title_id_path(my_params)
  end
  
  def add_clip_bss(bss, clip, params)
    my_params = my_params_bss(bss, params)
    my_params[:clip_id] = clip
    add_clip_bss_title_id_path(my_params)
  end
  
  
  def my_params_bss(bss, params)
    {id: bss, search: params[:search], channel_data_show: params[:channel_data_show], channel_add_show: params[:channel_add_show], 
                  clip_data_show: params[:clip_data_show], clip_add_show: params[:clip_add_show], search_clip: params[:search_clip], 
                  source: params[:source]}
  end
    
  
end
