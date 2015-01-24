# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Course < ActiveRecord::Base

  has_many :lectures
  has_many :course_sections
  has_many :schedules, through: :schedule_courses

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

end
