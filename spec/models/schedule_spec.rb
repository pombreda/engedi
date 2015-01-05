# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  status     :string(255)
#  name       :string(255)
#  folder     :string(255)
#  break_slot :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Schedule do
  pending "add some examples to (or delete) #{__FILE__}"
end
