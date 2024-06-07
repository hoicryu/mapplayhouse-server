class CreateTimeLists < ActiveRecord::Migration[6.0]
  def change
    create_table :time_lists do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
