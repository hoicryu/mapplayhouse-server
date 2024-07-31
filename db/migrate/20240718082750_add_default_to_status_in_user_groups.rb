class AddDefaultToStatusInUserGroups < ActiveRecord::Migration[6.0]
  def change
    change_column :user_groups, :status, :integer, :default => 0
  end
end
