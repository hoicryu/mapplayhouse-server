class AddCourseStartAtToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :course_start_at, :datetime
  end
end
