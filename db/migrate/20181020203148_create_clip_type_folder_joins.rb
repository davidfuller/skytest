class CreateClipTypeFolderJoins < ActiveRecord::Migration
  def change
    create_table :clip_type_folder_joins do |t|
      t.integer :clip_type_id
      t.integer :folder_id

      t.timestamps null: false
    end
  end
end
