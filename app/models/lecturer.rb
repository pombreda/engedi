# == Schema Information
#
# Table name: lecturers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  department :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Lecturer < ActiveRecord::Base

  has_many :course_sections

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

end
