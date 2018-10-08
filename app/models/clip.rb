class Clip < ActiveRecord::Base
  belongs_to :folder
  belongs_to :clip_type
  belongs_to :user
  belongs_to :status
  
  has_many :clip_device_joins
  has_many :device_types, through: :clip_device_joins

  has_many :clip_channel_joins
  has_many :channels, through: :clip_channel_joins

  has_many :bss_clip_joins
  has_many :bss_title_ids, through: :bss_clip_joins
  attr_accessor :device_data_show, :tx_channel_data_show, :promo_channel_data_show, :device_add_show, :channel_add_show, :bss_add_show, :bss_data_show

  def completion_date_string
    format_my_date completion
  end

  def completion_date_string=(date_string)
    self.completion = parse_my_date(date_string)
  end

  def first_use_date_string
    format_my_date first_use
  end

  def first_use_date_string=(date_string)
    self.first_use = parse_my_date(date_string)
  end

  def last_use_date_string
    format_my_date last_use
  end

  def last_use_date_string=(date_string)
    self.last_use = parse_my_date(date_string)
  end

  def device_already_present(device_id)
    if device_id
      device_types.where('device_types.id = ?', device_id).present?
    else
      false
    end
  end

  def channel_already_present(channel_id, tx)
    if channel_id
      clip_channel_joins.where('channel_id = ? AND tx = ?', channel_id, tx == :tx).present?
    else
      false
    end
  end

  def bss_already_present(bss_id)
    if bss_id
      bss_title_ids.where('bss_title_ids.id = ?', bss_id).present?
    else
      false
    end
  end

  def tx_channels
    clip_channel_joins.where('tx = ?', true).joins(:channel).order('channels.name')
  end
  def promo_channels
    clip_channel_joins.where('tx = ?', false).joins(:channel).order('channels.name')
  end

  def delete_channel(channel, tx)
    num = 0
    channel_joins = clip_channel_joins.where('channel_id = ? AND tx = ?', channel, tx == :tx)
    channel_joins.each do |join|
      join.delete
      num += 1
    end
    num
  end

  def view_options=(params)
    self.device_data_show = params[:device_data_show] == 'true'
    self.device_add_show = params[:device_add_show] == 'true'
    self.tx_channel_data_show = params[:tx_data_show] == 'true'
    self.promo_channel_data_show = params[:promo_data_show] == 'true'
    self.channel_add_show = params[:channel_add_show] == 'true'
    self.bss_data_show = params[:bss_data_show] == 'true'
    self.bss_add_show = params[:bss_add_show] == 'true'
    
  end

  private

  def parse_my_date(the_date_string)
    t = Time.zone.parse(the_date_string)
    t = t + 12.hour - t.hour
  end

  def format_my_date(the_date)
    if the_date
      the_date.strftime('%d-%m-%Y')
    else
      ''
    end
  end


end
