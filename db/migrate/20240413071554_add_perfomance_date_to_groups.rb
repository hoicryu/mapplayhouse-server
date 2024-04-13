class AddPerfomanceDateToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :performance_date, :datetime
  end
end
