class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :level
      t.string :section

      t.string :level_designation

      t.timestamps
    end
  end
end
