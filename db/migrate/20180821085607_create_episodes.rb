class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :year
      t.string :season
      t.string :episode
      t.belongs_to :title, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
