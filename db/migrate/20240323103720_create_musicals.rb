class CreateMusicals < ActiveRecord::Migration[6.0]
  def change
    create_table :musicals do |t|
      t.string :title
      t.text :body
      t.integer :type
      t.string :image
      t.timestamps
    end
  end
end
