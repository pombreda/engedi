require 'spec_helper'

describe "course_groups/new" do
  before(:each) do
    assign(:course_group, stub_model(CourseGroup).as_new_record)
  end

  it "renders new course_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_groups_path, "post" do
    end
  end
end
