class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.references :musical, null: false, foreign_key: true
      t.string :title
      t.integer :status
      t.datetime :audition_start_at
      t.datetime :audition_end_at
      t.timestamps
    end
  end
end
