class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.string :name
      t.text :note
      t.string :filename
      t.integer :folder_id
      t.boolean :has_audio
      t.string :audio_filename
      t.integer :clip_type_id
      t.integer :duration
      t.string :start_season
      t.string :start_episode
      t.string :end_season
      t.string :end_episode
      t.boolean :season_generic
      t.boolean :totally_generic
      t.time :first_use
      t.time :last_use
      t.time :completion
      t.integer :user_id
      t.integer :status_id

      t.timestamps null: false
    end
  end
end
