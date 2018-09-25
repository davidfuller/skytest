class Channel < ActiveRecord::Base

  belongs_to :channel_type

  has_many :bss_channel_joins
  has_many :bss_title_ids, through: :bss_channel_joins
  has_many :clip_type_channel_joins
  has_many :clip_types, through: :clip_type_channel_joins

  validates_uniqueness_of :name, :messsage => " is already in system"
	validates_presence_of :name, :code

  default_scope { order(:name) }
  self.per_page = 12
	
	def self.search(search, page)
		if search
			where('name LIKE ?', "%#{search}%").paginate(page: page)
		else
			paginate	:page => page
		end
  end
  
  def self.bss_title_id_search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def self.channel_and_code_search(search, search_code)
    if search_code.present?
      where('code = ?', search_code)
    elsif search.present?
      where('name = ?', search)
    else
      nil
    end
  end      

end
