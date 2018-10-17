module BssTitleIdsHelper

  def remove_channel_bss(bss, channel, params)
    my_params = {id: bss, channel_id: channel, search: params[:search], channel_data_show: params[:channel_data_show], channel_add_show: params[:channel_add_show], 
                  clip_data_show: params[:clip_data_show], clip_add_show: params[:clip_add_show], search_clip: params[:search_clip]}
    remove_channel_bss_title_id_path(my_params)
  end
  
  def remove_clip_bss(bss, clip, params)
    my_params = {id: bss, clip_id: clip, search: params[:search], channel_data_show: params[:channel_data_show], channel_add_show: params[:channel_add_show], 
                  clip_data_show: params[:clip_data_show], clip_add_show: params[:clip_add_show], search_clip: params[:search_clip]}
    remove_clip_bss_title_id_path(my_params)
  end
end
