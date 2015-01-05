require 'spec_helper'

describe "course_groups/show" do
  before(:each) do
    @course_group = assign(:course_group, stub_model(CourseGroup))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
