# == Schema Information
#
# Table name: courses
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  code            :string(255)
#  occurrence      :integer
#  slot_lock_index :integer
#  day_lock_index  :integer
#  duration        :float
#  course_group_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Course < ActiveRecord::Base

  belongs_to :course_group

  has_one :lecturer

  has_many :lectures
  has_many :schedules, through: :schedule_courses

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true

end
