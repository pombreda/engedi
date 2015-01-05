# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  day_index  :integer
#  time_slot  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Period < ActiveRecord::Base

  has_many :start_period_lectures, :class_name => 'Lecture', foreign_key: 'start_period_id'
  has_many :end_period_lectures, :class_name => 'Lecture', foreign_key: 'end_period_id'

end
