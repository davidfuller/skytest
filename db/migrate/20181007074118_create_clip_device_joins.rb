class CreateClipDeviceJoins < ActiveRecord::Migration
  def change
    create_table :clip_device_joins do |t|
      t.integer :clip_id
      t.integer :device_type_id

      t.timestamps null: false
    end
  end
end
