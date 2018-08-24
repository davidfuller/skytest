class Title < ActiveRecord::Base

	has_many :episodes, dependent: :destroy
	
	default_scope { order(:title) }
	
	validates_uniqueness_of :title, :messsage => " is already in system"
	validates_presence_of :title
	
	self.per_page = 15
	
	def self.search(search, page)
		if search
			where('title LIKE ?', "%#{search}%").paginate(page: page)
		else
			paginate	:page => page
		end
	end
	
	def season_list
		episodes.pluck(:season).uniq.insert(0,"All")
	end
	
	def episodes_for_season(season_number)
		if season_number == "All"
			episodes
		else
			episodes.where('season = ?', season_number)
		end
	end


	
end
