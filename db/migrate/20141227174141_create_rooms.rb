class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :code

      t.integer :capacity

      t.timestamps
    end
  end
end
