# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  status     :string(255)
#  name       :string(255)
#  folder     :string(255)
#  break_slot :integer
#  created_at :datetime
#  updated_at :datetime
#

class Schedule < ActiveRecord::Base

  STATUS_NOT_STARTED = "Not Started"
  STATUS_IN_PROGRESS = "In Progress"
  STATUS_COMPLETED = "Completed"

  has_many :lectures
  has_many :schedule_courses
  has_many :courses, through: :schedule_courses
  has_many :schedule_rooms
  has_many :rooms, through: :schedule_rooms

  def not_started?
    self.status == STATUS_NOT_STARTED
  end

  def in_progress?
    self.status == STATUS_IN_PROGRESS
  end

  def complete?
    self.status == STATUS_COMPLETED
  end

end
