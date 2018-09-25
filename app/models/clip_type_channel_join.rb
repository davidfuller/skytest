class ClipTypeChannelJoin < ActiveRecord::Base

  belongs_to :clip_type
  belongs_to :channel

  default_scope {includes(:channel).order(Channel.arel_table[:name]) }

end
