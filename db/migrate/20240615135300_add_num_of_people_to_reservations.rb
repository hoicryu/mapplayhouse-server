class AddNumOfPeopleToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :num_of_people, :integer
  end
end
