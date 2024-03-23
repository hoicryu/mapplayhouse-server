class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.datetime :start_at
      t.datetime :end_at
      t.string :note
      t.timestamps
    end
  end
end
