class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :status
      t.string :name
      t.string :folder

      t.integer :break_slot

      t.timestamps
    end
  end
end
