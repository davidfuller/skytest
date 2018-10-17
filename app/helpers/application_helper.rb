module ApplicationHelper

	def my_paginate(items)
		will_paginate items
  end
  
  def my_search(path)
    form_tag path, :method => 'get', :class => 'form-inline' do
    concat  '<span class="input-group-btn">'
    concat text_field_tag :search, params[:search], {:class => 'form-control field-title-search', :placeholder => "Search", :autofocus => true}
    concat button_tag type: 'submit', :class => 'btn btn-default' do %>
    concat <i class="glyphicon glyphicon-search"></i>'
    concat end
    concat button_tag "Clear", type: :button, :class => 'btn btn-default', :onclick =>'document.getElementById("search").value=""'
    concat '</span>'
    concat end
  end


  def remove_device(source, clip_type, device, params)
    my_params = {id: clip_type, device_id: device, promo_data_show: params[:promo_data_show], tx_data_show: params[:tx_data_show], search: params[:search], 
                  channel_add_show: params[:channel_add_show], bss_add_show: params[:bss_add_show], bss_data_show: params[:bss_data_show], search_bss: params[:search_bss]}
    
    if source == :clip_type
      remove_device_type_clip_type_path(my_params)
    elsif source == :clip
      remove_device_type_clip_path(my_params)
    end
  end
  
  def add_device(source, clip_type, device, params)
    my_params = {id: clip_type, device_id: device, promo_data_show: params[:promo_data_show], tx_data_show: params[:tx_data_show], search: params[:search], 
                  channel_add_show: params[:channel_add_show], bss_add_show: params[:bss_add_show], bss_data_show: params[:bss_data_show], search_bss: params[:search_bss]}
    
    if source == :clip_type
      add_device_type_clip_type_path(my_params)
    elsif source == :clip
      add_device_type_clip_path(my_params)
    end
  end

  def remove_channel(source, tx, clip_type, channel, params)
    my_params = {id: clip_type, channel_id: channel, search: params[:search], tx_data_show: params[:tx_data_show], device_add_show: params[:device_add_show], 
                  device_data_show: params[:device_data_show], bss_add_show: params[:bss_add_show], bss_data_show: params[:bss_data_show], search_bss: params[:search_bss]}
    
    if source == :clip_type
      if tx == :tx
        remove_tx_channel_clip_type_path(my_params)
      else
        remove_promo_channel_clip_type_path(my_params)
      end
    elsif source == :clip
      if tx == :tx
        remove_tx_channel_clip_path(my_params)
      else
        remove_promo_channel_clip_path(my_params)
      end
    end
  end

  def add_channel(source, tx, clip_type, channel, params)
    my_params = {id: clip_type, channel_id: channel, search: params[:search], promo_data_show: params[:promo_data_show], device_add_show: params[:device_add_show], 
                  device_data_show: params[:device_data_show], bss_add_show: params[:bss_add_show], bss_data_show: params[:bss_data_show], search_bss: params[:search_bss]}
    
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
