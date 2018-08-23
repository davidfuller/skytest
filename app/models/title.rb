class Title < ActiveRecord::Base

	has_many :episodes
	
	default_scope { order(:title) }
	
	validates_uniqueness_of :title, :messsage => " is already in system"
	validates_presence_of :title
	
	def self.search(search, page)
		if search
			where('title LIKE ?', "%#{search}%").paginate(page: page, per_page: 20)
		else
			paginate  :per_page => 20, :page => page
		end
	end
	
end
