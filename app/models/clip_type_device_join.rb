class ClipTypeDeviceJoin < ActiveRecord::Base

  belongs_to :clip_type
  belongs_to :device_type

end
