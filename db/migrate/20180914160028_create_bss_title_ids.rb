class CreateBssTitleIds < ActiveRecord::Migration
  def change
    create_table :bss_title_ids do |t|
      t.string :bss_title_id
      t.integer :episode_id

      t.timestamps null: false
    end
  end
end
