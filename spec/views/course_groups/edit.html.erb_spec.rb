require 'spec_helper'

describe "course_groups/edit" do
  before(:each) do
    @course_group = assign(:course_group, stub_model(CourseGroup))
  end

  it "renders the edit course_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_group_path(@course_group), "post" do
    end
  end
end
