class CreateBssChannelJoins < ActiveRecord::Migration
  def change
    create_table :bss_channel_joins do |t|
      t.integer :channel_id
      t.integer :bss_title_id_id
      
      t.timestamps null: false
    end
  end
end
