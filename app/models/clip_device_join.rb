class ClipDeviceJoin < ActiveRecord::Base

  belongs_to :clip
  belongs_to :device_type
  
end
