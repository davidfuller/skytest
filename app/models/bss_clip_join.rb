class BssClipJoin < ActiveRecord::Base

  belongs_to :clip
  belongs_to :bss_title_id
  
end
