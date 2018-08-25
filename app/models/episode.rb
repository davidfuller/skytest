class Episode < ActiveRecord::Base
  belongs_to :title
  
  default_scope { order(:int_season).order(:int_episode).order(:int_year) }
  
  attr_accessor :source
  attr_accessor :season_choice
    
  def self.numericise(ep)
  	ep.int_year = ep.year.to_i
  	ep.int_season = ep.season.to_i
  	ep.int_episode = ep.episode.to_i
  end
      
end
