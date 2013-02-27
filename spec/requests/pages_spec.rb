require 'spec_helper'

describe "Pages" do
  let!(:page) { Page.create! :title => "foo", :content => "bar" }

  describe "GET /api/pages" do
    it "returns a list of pages" do
      get "/api/pages.json"
      expect(response).to be_success
      expect(response.body).to include(page.to_json)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "GET /api/pages/:id" do
    it "returns one page" do
      get "/api/pages/#{page.id}.json"
      expect(response).to be_success
      expect(response.body).to eq(page.to_json)
    end
  end

  describe "POST /api/pages" do
    context "valid parameters" do
      it "creates a new page" do
        post "/api/pages.json", { :page => {:title => "new", :content => "page"} }
        expect(response).to be_success
        expect(response.body).to eq(Page.last.to_json)
      end
    end

    context "invalid parameters" do
      it "returns an error" do
        post "/api/pages.json", { :page => {:title => page.title, :content => "page"} }
        expect(response).to be_client_error
        expected_response = {
          "errors" => {
              "title" => [
                  "has already been taken"
              ]
          }
        }
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end
  end

  describe "PUT /api/pages/:id" do
    context "valid parameters" do
      it "updates a page" do
        put "/api/pages/#{page.id}.json",
            { :id => page.id.to_s, :page => {:title => "new" } }
        expect(response).to be_success
        expect(page.reload.title).to eq("new")
      end
    end

    context "invalid parameters" do
      it "returns an error" do
        put "/api/pages/#{page.id}.json",
            { :id => page.id.to_s, :page => {:title => "" } }
        expect(response).to be_client_error
        expected_response = {
          "errors" => {
              "title" => [
                  "can't be blank"
              ]
          }
        }
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end
  end

  describe "DELETE /api/pages/:id" do
    it "deletes a page" do
      delete "/api/pages/#{page.id}.json"
      expect(response).to be_success
      expect(Page.count).to eq(0)
    end
  end
end
