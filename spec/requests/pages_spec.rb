require 'spec_helper'

describe "Pages" do
  describe "GET /pages" do
    it "does not blow up" do
      get "/pages.json"
      response.status.should be(200)
    end
  end
end
