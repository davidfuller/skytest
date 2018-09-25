class ClipType < ActiveRecord::Base

  default_scope { order(:name) }
	
	validates_uniqueness_of :name, :messsage => " is already in system"
  validates_presence_of :name
  
    def default_has_audio_display
    if default_has_audio
      'Has Audio'
    else
      ''
    end
  end
	

end
