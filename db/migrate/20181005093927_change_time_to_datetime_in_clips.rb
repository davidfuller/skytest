class ChangeTimeToDatetimeInClips < ActiveRecord::Migration
  def self.up
    change_column :clips, :first_use, :datetime
    change_column :clips, :last_use, :datetime
    change_column :clips, :completion, :datetime
  end
  def self.down
    change_column :clips, :first_use, :time
    change_column :clips, :last_use, :time
    change_column :clips, :completion, :time
  end
end
