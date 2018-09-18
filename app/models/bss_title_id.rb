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
  
  def self.search_title(search,page)
    if search
      bss_ids = []
      titles = Title.where('title LIKE ?', "%#{search}%")
      titles.each do |title|
        title.bss_title_ids.each do |bss|
          bss_ids << bss.id
        end
      end
      find(bss_ids).paginate(page: page)
    else
      paginate(page: page)
    end
  end
end
