class ClipType < ActiveRecord::Base

  default_scope { order(:name) }

  has_many :clip_type_device_joins
  has_many :device_types, through: :clip_type_device_joins

  has_many :clip_type_channel_joins
  has_many :channels, through: :clip_type_channel_joins

	validates_uniqueness_of :name, :messsage => " is already in system"
  validates_presence_of :name
  
  attr_accessor :device_data_show, :tx_channel_data_show

  def default_has_audio_display
    if default_has_audio
      'Has Audio'
    else
      'No Audio'
    end
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
      clip_type_channel_joins.where('channel_id = ? AND tx = ?', channel_id, tx).present?
    else
      false
    end
  end

  def tx_channels
    clip_type_channel_joins.where('tx = ?', true).joins(:channel).order('channels.name')
  end
  def promo_channels
    clip_type_channel_joins.where('tx = ?', false).joins(:channel).order('channels.name')
  end

  def delete_channel(channel, tx)
    num = 0
    channel_joins = clip_type_channel_joins.where('channel_id = ? AND tx = ?', channel, tx)
    channel_joins.each do |join|
      join.delete
      num += 1
    end
    num
  end
end
