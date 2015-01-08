require 'spec_helper'

describe "course_sections/show" do
  before(:each) do
    @course_section = assign(:course_section, stub_model(CourseSection))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
