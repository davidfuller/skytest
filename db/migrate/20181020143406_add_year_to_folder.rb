class AddYearToFolder < ActiveRecord::Migration
  def change
    add_column :folders, :year, :integer
  end
end
