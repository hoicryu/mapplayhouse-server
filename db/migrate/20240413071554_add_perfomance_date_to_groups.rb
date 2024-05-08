class AddPerfomanceDateToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :performance_start_at, :datetime
    add_column :groups, :performance_end_at, :datetime
  end
end
