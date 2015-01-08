class CreateCourseSections < ActiveRecord::Migration
  def change
    create_table :course_sections do |t|

      t.timestamps
    end
  end
end
