class AddConcertHallToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :concert_hall, :string
  end
end
