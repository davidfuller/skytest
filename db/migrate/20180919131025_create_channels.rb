class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :code
      t.integer :channel_type_id

      t.timestamps null: false
    end
  end
end
