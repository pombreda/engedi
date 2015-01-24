# == Schema Information
#
# Table name: sections
#
#  id                :integer          not null, primary key
#  level             :string(255)
#  section           :string(255)
#  level_designation :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Section < ActiveRecord::Base

  has_many :course_sections

  validates :level, presence: true, :uniqueness => {scope: [:section]}
  validates :section, presence: true, :uniqueness => {scope: [:level]}

  def self.find_or_create(level, section)
    s = self.find_by({level: level, section: section})
    s = self.create({level: level, section: section}) unless s.present?
    return s
  end

end
