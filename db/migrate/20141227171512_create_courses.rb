class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code

      t.integer :occurrence

      t.float :duration

      t.belongs_to :course_group

      t.timestamps
    end
  end
end
