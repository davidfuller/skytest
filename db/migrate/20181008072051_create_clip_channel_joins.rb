class CreateClipChannelJoins < ActiveRecord::Migration
  def change
    create_table :clip_channel_joins do |t|
      t.integer :clip_id
      t.integer :channel_id
      t.boolean :tx

      t.timestamps null: false
    end
  end
end
