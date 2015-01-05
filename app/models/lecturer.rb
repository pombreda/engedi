# == Schema Information
#
# Table name: lecturers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  department :string(255)
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Lecturer < ActiveRecord::Base

  belongs_to :course

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

end
