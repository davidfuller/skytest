class AddNumericsToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :int_year, :integer
    add_column :episodes, :int_season, :integer
    add_column :episodes, :int_episode, :integer
  end
end
