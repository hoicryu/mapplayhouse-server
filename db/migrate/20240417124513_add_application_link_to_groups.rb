class AddApplicationLinkToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :application_link, :string
  end
end
