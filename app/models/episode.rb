class Episode < ActiveRecord::Base
  belongs_to :title
  
  default_scope { order(:season.to_i).order(:episode).order(:year) }
  
  attr_accessor :source
  
  
end
