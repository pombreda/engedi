# == Schema Information
#
# Table name: lectures
#
#  id                :integer          not null, primary key
#  course_section_id :integer
#  room_id           :integer
#  start_period_id   :integer
#  end_period_id     :integer
#  schedule_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Lecture < ActiveRecord::Base

  belongs_to :course_section
  belongs_to :room

  belongs_to :start_period, class_name: 'Period', foreign_key: 'start_period_id'
  belongs_to :end_period, class_name: 'Period', foreign_key: 'end_period_id'

  belongs_to :schedule

  def duration
    (end_period.time_slot - start_period.time_slot) + 1
  end

end
