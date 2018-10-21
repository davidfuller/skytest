class Clip < ActiveRecord::Base
  belongs_to :folder
  belongs_to :clip_type
  belongs_to :user
  belongs_to :status
  
  has_many :clip_device_joins
  has_many :device_types, through: :clip_device_joins

  has_many :clip_channel_joins
  has_many :channels, through: :clip_channel_joins

  has_many :bss_clip_joins
  has_many :bss_title_ids, through: :bss_clip_joins

  default_scope { order(:name) }

  attr_accessor :device_data_show, :tx_channel_data_show, :promo_channel_data_show, :device_add_show, :channel_add_show, :bss_add_show, :bss_data_show, :dummy_bss_id


  def self.search(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			all
		end
	end

  def completion_date_string
    format_my_date completion
  end

  def completion_date_string=(date_string)
    self.completion = parse_my_date(date_string)
  end

  def first_use_date_string
    format_my_date first_use
  end

  def first_use_date_string=(date_string)
    self.first_use = parse_my_date(date_string)
  end

  def last_use_date_string
    format_my_date last_use
  end

  def last_use_date_string=(date_string)
    self.last_use = parse_my_date(date_string)
  end

  def device_already_present(device_id)
    if device_id
      device_types.where('device_types.id = ?', device_id).present?
    else
      false
    end
  end

  def channel_already_present(channel_id, tx)
    if channel_id
      clip_channel_joins.where('channel_id = ? AND tx = ?', channel_id, tx == :tx).present?
    else
      false
    end
  end

  def bss_already_present(bss_id)
    if bss_id
      bss_title_ids.where('bss_title_ids.id = ?', bss_id).present?
    else
      false
    end
  end

  def tx_channels
    clip_channel_joins.where('tx = ?', true).joins(:channel).order('channels.name')
  end
  def promo_channels
    clip_channel_joins.where('tx = ?', false).joins(:channel).order('channels.name')
  end

  def delete_channel(channel, tx)
    num = 0
    channel_joins = clip_channel_joins.where('channel_id = ? AND tx = ?', channel, tx == :tx)
    channel_joins.each do |join|
      join.delete
      num += 1
    end
    num
  end

  def view_options=(params)
    self.device_data_show = params[:device_data_show] == 'true'
    self.device_add_show = params[:device_add_show] == 'true'
    self.tx_channel_data_show = params[:tx_data_show] == 'true'
    self.promo_channel_data_show = params[:promo_data_show] == 'true'
    self.channel_add_show = params[:channel_add_show] == 'true'
    self.bss_data_show = params[:bss_data_show] == 'true'
    self.bss_add_show = params[:bss_add_show] == 'true'
  end

  def specificity
    if totally_generic
      'Totally Generic'
    elsif season_generic
      'Season ' + start_season.strip + ' Generic'
    elsif start_season.strip.downcase == end_season.strip.downcase && start_episode.strip.downcase == end_episode.strip.downcase
      'Episodic ' + season_episode_string(start_season, start_episode)
    else
      'Episode Range ' + season_episode_string(start_season, start_episode) + ' to ' + season_episode_string(end_season, end_episode)
    end
  end

  def clip_from_bss(bss_title_id, clip_type, specificity)
    if bss_title_id.present?
      bss = BssTitleId.find(bss_title_id)
      if bss
        self.season_generic = specificity == 'Season Generic'
        self.totally_generic = specificity == 'Totally Generic'
        self.name = bss.episode.title.title + " " + bss.episode.clip_desciption(self.totally_generic, self.season_generic)
        self.note = 'Auto created at ' + format_my_date(Time.current)
        
        self.completion = Time.current.next_week.advance(days: 3, hours: 16) #next Thursday 18:00
        clip_type = ClipType.find(clip_type[:id])
        if clip_type then
          self.clip_type = clip_type
          self.has_audio = clip_type.default_has_audio
          self.duration = clip_type.default_duration
          self.folder = Folder.folder_for_clip(clip_type.id, self.completion.year)
          self.name += ' ' + clip_type.clip_code
        end
        self.filename = self.name.upcase.tr(" ", "_")
        if self.has_audio
          self.audio_filename = self.filename + ' (A1&2)'
        end
        self.start_season = bss.episode.season
        self.end_season = bss.episode.season
        self.start_episode = bss.episode.episode
        self.end_episode = bss.episode.episode
        self.first_use = self.completion.next_week.advance(hours: 6) #the following Monday 06:00
        self.last_use = self.first_use + 3.weeks
        self.user = User.find_by(name: 'Unallocated')
        self.status = Status.find_by(name: 'Commissioned')
        self.dummy_bss_id = bss_title_id
      end
    end
  end

  private

  def parse_my_date(the_date_string)
    t = Time.zone.parse(the_date_string)
    if t
      t = t + 12.hour - t.hour
    end
  end

  def format_my_date(the_date)
    if the_date
      the_date.strftime('%d-%m-%Y')
    else
      ''
    end
  end
  
  def season_episode_string(season, episode)
    int_season = Integer(season) rescue nil
    int_episode = Integer(episode) rescue nil
    if int_season && int_episode
      'S' + format('%02d', int_season) + 'E' + format('%02d', int_episode)
    elsif int_season
      'S' + format('%02d', int_season) + 'E' + episode.strip
    elsif int_episode
      'S' + season.strip + 'E' + format('%02d', int_episode)
    else
      'S' + season.strip + 'E' + episode.strip
    end
  end

end
