class Title < ActiveRecord::Base

  has_many :episodes, dependent: :destroy
  has_many :bss_title_ids, through :episodes
	
	default_scope { order(:title) }
	
	validates_uniqueness_of :title, :messsage => " is already in system"
	validates_presence_of :title
	
	self.per_page = 12
	
	def self.search(search, page)
		if search
			where('title LIKE ?', "%#{search}%").paginate(page: page)
		else
			paginate	:page => page
		end
	end
	
	def season_list
		sl = episodes.pluck(:season).uniq.insert(0,"All")
		sl.map { |x| x == "" ? 'No Season' : x }
	end
	
	def episodes_for_season(season_number)
	
		if season_number == "All" || season_number.nil? || season_number == ""
			episodes
		elsif season_number == "No Season"
			episodes.where('season = ?', "")
		else
			episodes.where('season = ?', season_number)
		end
	end
end
