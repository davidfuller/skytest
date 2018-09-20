class CreateBssChannelJoins < ActiveRecord::Migration
  def change
    create_table :bss_channel_joins do |t|

      t.timestamps null: false
    end
  end
end
