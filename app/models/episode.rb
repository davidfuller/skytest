class Episode < ActiveRecord::Base
  belongs_to :title
  
  default_scope { order(:season).order(:episode).order(:year) }
  
  attr_accessor :source
  
  
end
