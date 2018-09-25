class ClipTypeChannelJoin < ActiveRecord::Base

  belongs_to :clip_type
  belongs_to :channel

end
