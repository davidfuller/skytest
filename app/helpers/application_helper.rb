module ApplicationHelper

	def my_paginate(items)
		will_paginate items
	end


  def remove_device(source, clip_type, device, params)
    my_params = {id: clip_type, device_id: device, promo_data_show: params[:promo_data_show], tx_data_show: params[:tx_data_show], search: params[:search], channel_add_show: params[:channel_add_show]}
    
    if source == :clip_type
      remove_device_type_clip_type_path(my_params)
    elsif source == :clip
      remove_device_type_clip_path(my_params)
    end
  end
  
  def add_device(source, clip_type, device, params)
    my_params = {id: @clip_type, device_id: device, promo_data_show: params[:promo_data_show], tx_data_show: params[:tx_data_show], search: params[:search], channel_add_show: params[:channel_add_show]}
    
    if source == :clip_type
      add_device_type_clip_type_path(my_params)
    elsif source == :clip
      add_device_type_clip_path(my_params)
    end
  end
  
end
