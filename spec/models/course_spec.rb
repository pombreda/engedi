# == Schema Information
#
# Table name: courses
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  code            :string(255)
#  occurrence      :integer
#  duration        :float
#  course_group_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Course do
  pending "add some examples to (or delete) #{__FILE__}"
end
