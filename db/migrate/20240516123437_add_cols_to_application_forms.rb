class AddColsToApplicationForms < ActiveRecord::Migration[6.0]
  def change
    add_column :application_forms, :name, :string
    add_column :application_forms, :birthday, :string
    add_column :application_forms, :phone, :string
    add_column :application_forms, :part_ids, :string, array: true, default: []
    add_column :application_forms, :signature, :string
  end
end
