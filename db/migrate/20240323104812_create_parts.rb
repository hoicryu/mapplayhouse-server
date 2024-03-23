class CreateParts < ActiveRecord::Migration[6.0]
  def change
    create_table :parts do |t|
      t.references :musical, null: false, foreign_key: true
      t.references :rating, null: false, foreign_key: true
      t.string :title
      t.string :image
      t.timestamps
    end
  end
end
