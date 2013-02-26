require 'spec_helper'

describe "Pages" do
  describe "GET /api/pages" do
    it "does not blow up" do
      get "/api/pages.json"
      response.status.should be(200)
    end
  end
end
