class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.string :name
      t.string :code
      t.string :department

      t.belongs_to :course

      t.timestamps
    end
  end
end
