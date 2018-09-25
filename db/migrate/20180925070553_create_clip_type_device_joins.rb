class CreateClipTypeDeviceJoins < ActiveRecord::Migration
  def change
    create_table :clip_type_device_joins do |t|
      t.integer :clip_type_id
      t.integer :device_type_id
      t.timestamps null: false
    end
  end
end
