class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name
      t.text :note
      t.string :clipstore
      t.string :proxy
      t.string :jpeg
      t.integer :clip_limit
      t.integer :overflow_id

      t.timestamps null: false
    end
  end
end
