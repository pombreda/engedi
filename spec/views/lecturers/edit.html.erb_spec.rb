require 'spec_helper'

describe "lecturers/edit" do
  before(:each) do
    @lecturer = assign(:lecturer, stub_model(Lecturer))
  end

  it "renders the edit lecturer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lecturer_path(@lecturer), "post" do
    end
  end
end
