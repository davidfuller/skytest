class ClipTypeFolderJoin < ActiveRecord::Base

  belongs_to :clip_type
  belongs_to :folder
  
end
