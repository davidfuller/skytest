class User < ActiveRecord::Base

    default_scope { order(:name) }
	
	validates_uniqueness_of :name, :messsage => " is already in system"
	validates_presence_of :name, :role
end
