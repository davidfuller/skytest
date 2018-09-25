class ClipType < ActiveRecord::Base

  default_scope { order(:name) }

  has_many :clip_type_device_joins
  has_many :device_types, through: :clip_type_device_joins

	
	validates_uniqueness_of :name, :messsage => " is already in system"
  validates_presence_of :name
  
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

	

end
