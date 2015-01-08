class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code

      t.integer :occurrence
      t.integer :slot_lock_index
      t.integer :day_lock_index

      t.float :duration

      t.belongs_to :course_group

      t.timestamps
    end
  end
end
