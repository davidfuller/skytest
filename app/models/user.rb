class User < ActiveRecord::Base

  default_scope { order(:name) }

  has_many :clips
	
	validates_uniqueness_of :name, :messsage => " is already in system"
	validates_presence_of :name, :role
end
