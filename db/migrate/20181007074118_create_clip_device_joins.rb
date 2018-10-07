class CreateClipDeviceJoins < ActiveRecord::Migration
  def change
    create_table :clip_device_joins do |t|

      t.timestamps null: false
    end
  end
end
