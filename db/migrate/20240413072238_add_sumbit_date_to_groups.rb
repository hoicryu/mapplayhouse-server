class AddSumbitDateToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :submit_start_at, :datetime
    rename_column :groups, :audition_end_at, :submit_end_at
    rename_column :groups, :audition_start_at, :audition_date
  end
end
