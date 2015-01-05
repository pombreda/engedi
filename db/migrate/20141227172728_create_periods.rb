class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :day_index
      t.integer :time_slot

      t.timestamps
    end
  end
end
