class BssChannelJoin < ActiveRecord::Base

  belongs_to :channel
  belongs_to :bss_title_id
  
end
