class AddShowTypeToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :show_type, :integer, default: 0
  end
end
