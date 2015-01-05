# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  capacity   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Room < ActiveRecord::Base

  has_many :lectures
  has_many :schedules, through: :schedule_rooms

end
