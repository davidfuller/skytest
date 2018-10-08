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
    my_params = {id: clip_type, device_id: device, promo_data_show: params[:promo_data_show], tx_data_show: params[:tx_data_show], search: params[:search], channel_add_show: params[:channel_add_show]}
    if source == :clip_type
      add_device_type_clip_type_path(my_params)
    elsif source == :clip
      add_device_type_clip_path(my_params)
    end
  end

  def remove_channel(source, tx, clip_type, channel, params)
    my_params = {id: clip_type, channel_id: device, search: params[:search], tx_data_show: params[:tx_data_show], device_add_show: params[:device_add_show], device_data_show: params[:device_data_show] }
    if source == :clip_type
      remove_promo_channel_clip_type_path(my_params)
    elsif source == :clip
      remove_promo_channel_clip_path(my_params)
    end
  end

  def add_channel(source, tx, clip_type, channel, params)
    my_params = {id: my_clip, channel_id: channel, search: params[:search], promo_data_show: params[:promo_data_show], device_add_show: params[:device_add_show], device_data_show: params[:device_data_show]}
    if source == :clip_type
        if tx == :tx
          add_tx_channel_clip_type_path(my_params)
        else
          add_promo_channel_clip_type_path(my_params)
        end
    elsif source == :clip
        if tx == :tx
          add_tx_channel_clip_path(my_params)
        else
          add_promo_channel_clip_path(my_params)
        end
    end
  end
  


  
end
