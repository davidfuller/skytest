class Folder < ActiveRecord::Base
  default_scope { order(:name) }
  after_initialize :set_defaults

  has_many :clips
  
  has_many :clip_type_folder_joins
  has_many :clip_types, through: :clip_type_folder_joins

  validate :overflow_cannot_be_itself, on: :update
  
  attr_accessor :clip_type_data_show, :clip_type_add_show

  def overflow_name
    if overflow_id
      Folder.find(overflow_id).name
    else
      ''
    end
  end

  def self.minus_none
    where.not(name: '<None>')
  end

  def clip_type_already_present(clip_type_id)
    if clip_type_id
      clip_types.where('clip_types.id = ?', clip_type_id).present?
    else
      false
    end
  end
  
  def view_options=(params)
    self.clip_type_data_show = params[:clip_type_data_show] == 'true'
    self.clip_type_add_show = params[:clip_type_add_show] == 'true'
  end

  def folder_for_clip(clip_type_id, year)
    folders = joins(:clip_types).where("clip_types.id=? AND year=?", clip_type_id, year)
    folders.each do |folder|
      return folder if folder.clips.count < folder.clip_limit
    end
    folders.each do |folder|
      overflow = find(overflow_id)
      return overflow if overflow.clips.count 
    end    
    nil
  end

  private

  def set_defaults
    self.clip_limit ||= 500 if self.new_record?
  end

  def overflow_cannot_be_itself
    if id == overflow_id
      errors.add(:overflow_id, 'cannot be the same folder')
    end
  end
  
  

end
