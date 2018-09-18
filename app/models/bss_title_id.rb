class BssTitleId < ActiveRecord::Base

  belongs_to :episode
 
  validates_presence_of :bss_title_id
  default_scope { order(:bss_title_id) }
  
  attr_accessor :source

	self.per_page = 12
	
	def self.search(search, page)
		if search
			where('bss_title_id LIKE ?', "%#{search}%").paginate(page: page)
		else
			paginate	:page => page
		end
	end
end
