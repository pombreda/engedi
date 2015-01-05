# == Schema Information
#
# Table name: schedule_courses
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  course_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class ScheduleCourse < ActiveRecord::Base

  belongs_to :schedule
  belongs_to :course

end
