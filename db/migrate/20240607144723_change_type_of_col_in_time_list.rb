class ChangeTypeOfColInTimeList < ActiveRecord::Migration[6.0]
  def change
    change_column(:time_lists, :start_at, :time)
    change_column(:time_lists, :end_at, :time)
  end
end
