class AddEpisodeTitleToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :episode_title, :string
  end
end
