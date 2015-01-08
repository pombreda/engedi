require "spec_helper"

describe CourseSectionsController do
  describe "routing" do

    it "routes to #index" do
      get("/course_sections").should route_to("course_sections#index")
    end

    it "routes to #new" do
      get("/course_sections/new").should route_to("course_sections#new")
    end

    it "routes to #show" do
      get("/course_sections/1").should route_to("course_sections#show", :id => "1")
    end

    it "routes to #edit" do
      get("/course_sections/1/edit").should route_to("course_sections#edit", :id => "1")
    end

    it "routes to #create" do
      post("/course_sections").should route_to("course_sections#create")
    end

    it "routes to #update" do
      put("/course_sections/1").should route_to("course_sections#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/course_sections/1").should route_to("course_sections#destroy", :id => "1")
    end

  end
end
