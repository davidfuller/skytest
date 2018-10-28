class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  default_scope { order(:name) }

  has_many :clips
	
	validates_uniqueness_of :name, :messsage => " is already in system"
	validates_presence_of :name, :role
	
end
