class Episode < ActiveRecord::Base
  belongs_to :title

  has_many :bss_title_ids, dependent: :destroy
  
  default_scope { order(:int_season).order(:int_episode).order(:int_year) }
  
  attr_accessor :source
  attr_accessor :season_choice
    
  def self.numericise(ep)
  	ep.int_year = ep.year.to_i
  	ep.int_season = ep.season.to_i
  	ep.int_episode = ep.episode.to_i
  end

  def season_episode
    'S' + format('%2d', int_year) + 'E' + format('%2d', int_episode)
  end
      
end
