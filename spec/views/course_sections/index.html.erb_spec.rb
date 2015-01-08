require 'spec_helper'

describe "course_sections/index" do
  before(:each) do
    assign(:course_sections, [
      stub_model(CourseSection),
      stub_model(CourseSection)
    ])
  end

  it "renders a list of course_sections" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
