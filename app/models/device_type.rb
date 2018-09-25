class DeviceType < ActiveRecord::Base

  has_many :clip_type_device_joins
  has_many :clip_types, through: :clip_type_device_joins

  default_scope { order(:name) }
	
	validates_uniqueness_of :name, :messsage => " is already in system"
  validates_presence_of :name
    
end
