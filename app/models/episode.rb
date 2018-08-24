class Episode < ActiveRecord::Base
  belongs_to :title
  
  default_scope { order(:int_season).order(:int_episode).order(:int_year) }
  
  attr_accessor :source
  
  
  def numericise
  	int_year = year.to_i
  	int_season = season.to_i
  	int_episode = spisode.to_i
  end
      
end
