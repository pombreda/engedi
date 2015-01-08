require 'spec_helper'

describe "course_sections/edit" do
  before(:each) do
    @course_section = assign(:course_section, stub_model(CourseSection))
  end

  it "renders the edit course_section form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_section_path(@course_section), "post" do
    end
  end
end
