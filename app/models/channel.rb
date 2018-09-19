class Channel < ActiveRecord::Base

  belongs_to :channel_type

  default_scope { order(:name) }

  
end
