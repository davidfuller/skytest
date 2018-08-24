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
	
end
