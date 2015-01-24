# == Schema Information
#
# Table name: course_sections
#
#  id                       :integer          not null, primary key
#  periods                  :integer
#  slot_lock_index          :integer
#  day_lock_index           :integer
#  course_id                :integer
#  section_id               :integer
#  lecturer_id              :integer
#  linked_course_section_id :integer
#  created_at               :datetime
#  updated_at               :datetime
#

class CourseSection < ActiveRecord::Base

  belongs_to :course
  belongs_to :section
  belongs_to :lecturer

  has_many :lectures

  belongs_to :linked_course_section, :class_name => "CourseSection", :foreign_key => "linked_course_section_id"
  has_many :linked_course_sections, :class_name => "CourseSection",:foreign_key => "linked_course_section_id"

  validates :course_id, presence: true, :uniqueness => {scope: :section_id}
  validates :section_id, presence: true, :uniqueness => {scope: :course_id}

end
