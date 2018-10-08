class Clip < ActiveRecord::Base
  belongs_to :folder
  belongs_to :clip_type
  belongs_to :user
  belongs_to :status
  
  has_many :clip_device_joins
  has_many :device_types, through: :clip_device_joins

  has_many :clip_channel_joins
  has_many :channels, through: :clip_channel_joins

  attr_accessor :device_data_show, :tx_channel_data_show, :promo_channel_data_show, :device_add_show, :channel_add_show

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
