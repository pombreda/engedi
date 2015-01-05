require 'spec_helper'

describe "lecturers/index" do
  before(:each) do
    assign(:lecturers, [
      stub_model(Lecturer),
      stub_model(Lecturer)
    ])
  end

  it "renders a list of lecturers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
