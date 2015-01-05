class CreateScheduleCourses < ActiveRecord::Migration
  def change
    create_table :schedule_courses do |t|
      t.belongs_to :schedule
      t.belongs_to :course

      t.timestamps
    end
  end
end
