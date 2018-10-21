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

  def title_description
    if title
      title.title + ' ' + season_episode_year
    else
      'No title'
    end
  end
  
  def clip_descripton(totally_generic, season_generic)
    if totally_generic
      'Gen'
    elsif season_generic
      if int_season 
        if int_seaon > 0
          description = 'S' + format('%02d', int_season) + ' GN'
        end
      end
      if int_year && description.blank?
        if int_year > 0
          description = format('%04d', int_year) + ' GN'
        end
      end
      description
    else
      season_episode_or_year
    end
  end
        
  

  def season_episode_or_year
    if int_season && int_episode
      if int_season > 0 && int_episode > 0
        description = season_episode
      end
    end
    if int_year && description.blank?
      if int_year > 0
        description = format('%04d', int_year)
      end
    end
    if description
      description.squish
    else
      ''
    end
  end

  def season_episode_year
    if int_season && int_episode
      if int_season > 0 && int_episode > 0
        description = season_episode
      end
    end
    if int_year
      if int_year > 0
          if description
            description = description + ' (' + format('%04d', int_year) + ')'
          else
            description = '(' + format('%04d', int_year) + ')'
          end
      end
    end
    if description
      description.squish
    else
      ''
    end
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

  def self.search_title_season_episode_year(title, season, episode, year)
    if season != '0' && episode != '0'
      ep = all.joins(:title).where('titles.title = ?', title).where(season: season, episode: episode)
    elsif year != '0'
      ep = all.joins(:title).where('titles.title = ?', title).where(year: year)
    else
      ep = nil
    end
    ep
  end

end
