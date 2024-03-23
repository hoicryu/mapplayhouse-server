class CreateBanners < ActiveRecord::Migration[6.0]
  def change
    create_table :banners do |t|
      t.string :title
      t.text :body
      t.integer :type
      t.string :youtube_url
      t.timestamps
    end
  end
end
