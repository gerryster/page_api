require 'spec_helper'

# These tests are extremely mock heavy.  I am using integration tests can
# validate the whole stack.
describe PagesController do
  describe "GET index" do
    it "returns all posts" do
      Page.should_receive :all
      get :index, {}
    end
  end

  describe "GET show" do
    it "sends the requested id to Page" do
      Page.should_receive(:find).with("42")
      get :show, {:id => 42}
    end
  end

  describe "GET new" do
    it "calls new" do
      Page.should_receive(:new)
      get :new
    end
  end

  describe "GET edit" do
    it "sends the requested id to Page" do
      Page.should_receive(:find).with("42")
      get :edit, {:id => 42}
    end
  end

  describe "POST create" do
    it "saves a new Page" do
      params = { "title" => "Foo", "content" => "bar" }
      mock_page = mock_model(Page)
      Page.should_receive(:new).with(params).and_return mock_page
      mock_page.should_receive(:save).and_return :true

      post :create, {:page => params}
    end
  end

  describe "PUT update" do
    it "updates and existing page" do
      params = { "id" => "42", :page => { "title" => "Foo", "content" => "bar" }}
      mock_page = mock_model(Page)
      Page.should_receive(:find).with("42").and_return mock_page
      mock_page.should_receive(:update_attributes).with(params[:page]).and_return :true

      put :update, params
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested page" do
      mock_page = mock_model(Page)
      Page.should_receive(:find).with("42").and_return mock_page
      mock_page.should_receive(:destroy).and_return :true

      delete :destroy, {:id => "42"}
    end
  end

  describe "GET published" do
    it "gets published pages" do
      Page.should_receive(:published)
      get :published
    end
  end

  describe "GET unpublished" do
    it "gets unpublished pages" do
      Page.should_receive(:unpublished)
      get :unpublished
    end
  end

  describe "POST publish" do
    it "publishes a page" do
      mock_page = mock_model(Page)
      Page.should_receive(:find).with("42").and_return mock_page
      mock_page.should_receive(:published_on=).with(kind_of(Time))
      mock_page.should_receive(:save).and_return(:true)

      post :publish, {:id => "42"}
    end
  end
end
