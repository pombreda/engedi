class CreateCourseSections < ActiveRecord::Migration
  def change
    create_table :course_sections do |t|
      t.integer :periods
      t.integer :slot_lock_index
      t.integer :day_lock_index

      t.belongs_to :course
      t.belongs_to :section
      t.belongs_to :lecturer

      t.belongs_to :linked_course_section

      t.timestamps
    end
  end
end
