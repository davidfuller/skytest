class CreateClipTypeChannelJoins < ActiveRecord::Migration
  def change
    create_table :clip_type_channel_joins do |t|
      t.integer :clip_type_id
      t.integer :channel_id
      t.boolean :tx

      t.timestamps null: false
    end
  end
end
