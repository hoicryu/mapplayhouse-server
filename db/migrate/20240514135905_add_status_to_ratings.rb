class AddStatusToRatings < ActiveRecord::Migration[6.0]
  def change
    add_column :ratings, :status, :integer, default: 0
  end
end
