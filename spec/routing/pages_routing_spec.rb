require "spec_helper"

describe PagesController do
  describe "routing" do

    it "routes to #index" do
      get("/api/pages").should route_to("pages#index")
    end

    it "routes to #new" do
      get("/api/pages/new").should route_to("pages#new")
    end

    it "routes to #show" do
      get("/api/pages/1").should route_to("pages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/api/pages/1/edit").should route_to("pages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/api/pages").should route_to("pages#create")
    end

    it "routes to #update" do
      put("/api/pages/1").should route_to("pages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/api/pages/1").should route_to("pages#destroy", :id => "1")
    end

    it "routes to #published" do
      get("/api/pages/published").should route_to("pages#published")
    end

    it "routes to #unpublished" do
      get("/api/pages/unpublished").should route_to("pages#unpublished")
    end

    it "routes to #publish" do
      post("/api/pages/1/publish").should route_to("pages#publish", :id => "1")
    end

    it "routes to #total_words" do
      get("/api/pages/1/total_words").should route_to("pages#total_words", :id => "1")
    end
  end
end
