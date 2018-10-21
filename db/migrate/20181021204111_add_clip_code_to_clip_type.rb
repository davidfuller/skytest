class AddClipCodeToClipType < ActiveRecord::Migration
  def change
    add_column :clip_types, :clip_code, :string
  end
end
