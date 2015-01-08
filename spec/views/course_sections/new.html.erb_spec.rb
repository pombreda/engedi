require 'spec_helper'

describe "course_sections/new" do
  before(:each) do
    assign(:course_section, stub_model(CourseSection).as_new_record)
  end

  it "renders new course_section form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_sections_path, "post" do
    end
  end
end
