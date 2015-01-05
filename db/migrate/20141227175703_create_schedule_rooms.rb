class CreateScheduleRooms < ActiveRecord::Migration
  def change
    create_table :schedule_rooms do |t|
      t.belongs_to :schedule
      t.belongs_to :room

      t.timestamps
    end
  end
end
