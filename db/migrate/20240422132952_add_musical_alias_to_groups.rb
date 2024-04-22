class AddMusicalAliasToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :musical_alias, :string
  end
end
