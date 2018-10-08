class CreateBssClipJoins < ActiveRecord::Migration
  def change
    create_table :bss_clip_joins do |t|
      t.integer :bss_title_id_id
      t.integer :clip_id

      t.timestamps null: false
    end
  end
end
