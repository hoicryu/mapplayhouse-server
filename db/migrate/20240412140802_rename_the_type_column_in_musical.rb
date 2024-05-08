class RenameTheTypeColumnInMusical < ActiveRecord::Migration[6.0]
  def change
    rename_column :musicals, :type, :_type
  end
end
