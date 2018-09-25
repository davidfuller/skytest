class CreateClipTypeDeviceJoins < ActiveRecord::Migration
  def change
    create_table :clip_type_device_joins do |t|

      t.timestamps null: false
    end
  end
end
