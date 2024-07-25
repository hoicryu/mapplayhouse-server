class AddPartRefToUserGroups < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_groups, :part, foreign_key: true
  end
end
