class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.integer :position

      t.timestamps null: false
    end
  end
end
