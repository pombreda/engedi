require 'spec_helper'

describe "course_groups/index" do
  before(:each) do
    assign(:course_groups, [
      stub_model(CourseGroup),
      stub_model(CourseGroup)
    ])
  end

  it "renders a list of course_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
