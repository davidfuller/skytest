class CreateClipTypes < ActiveRecord::Migration
  def change
    create_table :clip_types do |t|
      t.string :name
      t.text :description
      t.integer :default_duration
      t.boolean :default_has_audio

      t.timestamps null: false
    end
  end
end
