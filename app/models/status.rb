class Status < ActiveRecord::Base

  default_scope { order(:position) }

  has_many :clips
  
  validates :name, :position, presence: true
  validates :position, uniqueness: { message: 'is already used' }

end
