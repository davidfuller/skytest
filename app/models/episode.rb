class Episode < ActiveRecord::Base
  belongs_to :title

  has_many :bss_title_ids, dependent: :destroy
  
  default_scope { order(:int_season).order(:int_episode).order(:int_year) }
  
  attr_accessor :source
  attr_accessor :season_choice
  
  self.per_page = 12

  def self.numericise(ep)
  	ep.int_year = ep.year.to_i
  	ep.int_season = ep.season.to_i
  	ep.int_episode = ep.episode.to_i
  end

  def season_episode
    'S' + format('%02d', int_season) + 'E' + format('%02d', int_episode)
  end

  def episode_description
    description = episode_title + ' ' + season_episode_year
    description.squish
  end

  def season_episode_year
    if int_season > 0 && int_episode > 0
      description = season_episode
    end
    if int_year > 0
        if description
          description = description + ' (' + format('%04d', int_year) + ')'
        else
          description = '(' + format('%04d', int_year) + ')'
        end
    end
    description.squish
  end

  def self.search_title_and_episode(search, page)
    if search
      episode_ids = []
      titles = Title.where('title LIKE ?', "%#{search}%")
      titles.each do |title|
        title.episode_ids.each do |ep|
          episode_ids << ep
        end
      end
      episode_search = where('episode_title LIKE ?', "%#{search}%")
      episode_search.each do |ep|
        episode_ids << ep.id
      end
      where(id: episode_ids).joins(:title).reorder('titles.title', :int_season, :int_episode, :int_year).paginate(page: page)
    else
      all.joins(:title).reorder('titles.title', :int_season, :int_episode, :int_year).paginate(page: page)
    end
  end
end
