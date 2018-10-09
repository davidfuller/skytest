module ClipsHelper

  def my_datepicker form, field
    form.text_field field, :data => {provide: 'datepicker', 'date-format' => 'dd-mm-yyyy', 'date-autoclose' => 'true', 'date-today-btn' => 'true', 'date-today-highlight' => 'true'}, class: 'form-control field-datepicker'
  end


  def remove_bss(clip, bss, params)
    my_params = {id: clip, bss_id: bss, promo_data_show: params[:promo_data_show], tx_data_show: params[:tx_data_show], search: params[:search], 
                  channel_add_show: params[:channel_add_show], search_bss: params[:search_bss]}
    
    remove_bss_clip_path(my_params)
  end
  
  def add_bss(clip, bss, params)
    my_params = {id: clip, bss_id: bss, promo_data_show: params[:promo_data_show], tx_data_show: params[:tx_data_show], search: params[:search], 
                  channel_add_show: params[:channel_add_show], search_bss: params[:search_bss]}
    
    add_bss_clip_path(my_params)
  end

end
