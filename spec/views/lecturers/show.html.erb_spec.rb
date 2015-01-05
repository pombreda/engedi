require 'spec_helper'

describe "lecturers/show" do
  before(:each) do
    @lecturer = assign(:lecturer, stub_model(Lecturer))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
