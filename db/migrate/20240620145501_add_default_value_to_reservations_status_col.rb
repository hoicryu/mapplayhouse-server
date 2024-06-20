class AddDefaultValueToReservationsStatusCol < ActiveRecord::Migration[6.0]
  def change
    change_column :reservations, :status, :integer, :default => 1
  end
end
