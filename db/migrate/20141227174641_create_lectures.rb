class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.belongs_to :course
      t.belongs_to :room

      t.belongs_to :start_period, class_name: 'Period', foreign_key: 'start_period_id'
      t.belongs_to :end_period, class_name: 'Period', foreign_key: 'end_period_id'

      t.belongs_to :schedule

      t.timestamps
    end
  end
end
