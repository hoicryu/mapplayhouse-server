class CreateNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :notices do |t|
      t.string :title
      t.text :body
      t.integer :position
      t.integer :status
      t.integer :_type
      t.timestamps
    end
  end
end
