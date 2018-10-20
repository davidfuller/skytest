class Folder < ActiveRecord::Base
  default_scope { order(:name) }
  after_initialize :set_defaults

  has_many :clips
  
  has_many :clip_type_folder_joins
  has_many :clip_types, through: :clip_type_folder_joins

  validate :overflow_cannot_be_itself, on: :update

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
