class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.text :answer
      t.integer :status
      t.timestamps
    end
  end
end
