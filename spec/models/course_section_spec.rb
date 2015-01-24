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

require 'spec_helper'

describe CourseSection do
  pending "add some examples to (or delete) #{__FILE__}"
end
