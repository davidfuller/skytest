class BssTitleId < ActiveRecord::Base

  belongs_to :episode

  has_many :bss_channel_joins
  has_many :channels, through: :bss_channel_joins
 
  has_many :bss_clip_joins
  has_many :clips, through: :bss_clip_joins
 
 
  validates_presence_of :bss_title_id, on: :update
  default_scope { order(:bss_title_id) }
  
  attr_accessor :source, :channel_data_show, :clip_data_show, :channel_add_show, :clip_add_show

	self.per_page = 12
	
	def self.search(search)
		if search
			where('bss_title_id LIKE ?', "%#{search}%")
		else
			all
		end
  end

  def self.search_title_and_bss_id_paged(search, page)
    search_title_and_bss_id(search).paginate(page: page)
  end
  
  def self.search_title_and_bss_id(search)
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
      where(id: bss_ids)
    else
      all
    end
  end

  def self.search_bss_title_id(search)
    where('bss_title_id = ?', search)
  end
  
  def view_options=(params)
    self.clip_data_show = params[:clip_data_show] == 'true'
    self.clip_add_show = params[:clip_add_show] == 'true'
    self.channel_data_show = params[:channel_data_show] == 'true'
    self.channel_add_show = params[:channel_add_show] == 'true'
  end

  def clip_already_present(clip_id)
    if clip_id
      clips.where('clips.id = ?', clip_id).present?
    else
      false
    end
  end

  def channel_already_present(channel_id)
    if channel_id
      channels.where('channels.channel_id = ?', channel_id).present?
    else
      false
    end
  end

  
end
