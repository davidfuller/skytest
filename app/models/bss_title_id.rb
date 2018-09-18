class BssTitleId < ActiveRecord::Base

  belongs_to :episode
 
  validates_presence_of :bss_title_id
  default_scope { order(:bss_title_id) }
  
  attr_accessor :source

	self.per_page = 12
	
	def self.search(search)
		if search
			where('bss_title_id LIKE ?', "%#{search}%")
		else
			all
		end
  end
  
  def self.search_title_and_bss_id(search, page)
    if search
      bss_ids = []
      titles = Title.where('title LIKE ?', "%#{search}%")
      titles.each do |title|
        title.bss_title_ids.each do |bss|
          bss_ids << bss.id
        end
      end
      bss_search = where('bss_title_id LIKE ?', "%#{search}%")
      bss_search.each do |bss|
        bss_ids << bss.id
      end

      where(id: bss_ids).paginate(page: page)
    else
      paginate(page: page)
    end
  end
end
