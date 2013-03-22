class CreateHistoryEvents < ActiveRecord::Migration
  def change
    create_table :history_events do |t|
      t.string :model
      t.text :data

      t.timestamps
    end
  end
end
