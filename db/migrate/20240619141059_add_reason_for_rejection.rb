class AddReasonForRejection < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :reason_for_rejection, :string
  end
end
