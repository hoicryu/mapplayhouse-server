class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.references :group, null: false, foreign_key: true
      t.string :title
      t.string :youtube_url
      t.integer :_type
      t.string :body
      t.timestamps
    end
  end
end
