class ClipChannelJoin < ActiveRecord::Base

  belongs_to :clip
  belongs_to :channel

end
