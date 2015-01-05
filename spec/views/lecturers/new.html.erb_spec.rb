require 'spec_helper'

describe "lecturers/new" do
  before(:each) do
    assign(:lecturer, stub_model(Lecturer).as_new_record)
  end

  it "renders new lecturer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lecturers_path, "post" do
    end
  end
end
