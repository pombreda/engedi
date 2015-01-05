# == Schema Information
#
# Table name: schedule_rooms
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  room_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class ScheduleRoom < ActiveRecord::Base

  belongs_to :schedule
  belongs_to :room

end
