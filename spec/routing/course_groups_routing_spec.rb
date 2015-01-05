require "spec_helper"

describe CourseGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/course_groups").should route_to("course_groups#index")
    end

    it "routes to #new" do
      get("/course_groups/new").should route_to("course_groups#new")
    end

    it "routes to #show" do
      get("/course_groups/1").should route_to("course_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/course_groups/1/edit").should route_to("course_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/course_groups").should route_to("course_groups#create")
    end

    it "routes to #update" do
      put("/course_groups/1").should route_to("course_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/course_groups/1").should route_to("course_groups#destroy", :id => "1")
    end

  end
end
