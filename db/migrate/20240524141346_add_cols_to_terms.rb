class AddColsToTerms < ActiveRecord::Migration[6.0]
  def change
    add_column :terms, :sub_content, :string
    add_column :terms, :check_yes, :boolean
  end
end
