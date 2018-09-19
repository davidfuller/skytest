class CreateChannelTypes < ActiveRecord::Migration
  def change
    create_table :channel_types do |t|
      t.string :name
      t.boolean :tx
      t.boolean :has_promotion

      t.timestamps null: false
    end
  end
end
