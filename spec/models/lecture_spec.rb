# == Schema Information
#
# Table name: lectures
#
#  id              :integer          not null, primary key
#  course_id       :integer
#  room_id         :integer
#  start_period_id :integer
#  end_period_id   :integer
#  schedule_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Lecture do
  pending "add some examples to (or delete) #{__FILE__}"
end
