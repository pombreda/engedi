# == Schema Information
#
# Table name: course_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CourseGroup < ActiveRecord::Base

  has_many :courses

end
