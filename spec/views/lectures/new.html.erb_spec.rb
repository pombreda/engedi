require 'spec_helper'

describe "lectures/new" do
  before(:each) do
    assign(:lecture, stub_model(Lecture).as_new_record)
  end

  it "renders new lecture form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lectures_path, "post" do
    end
  end
end
