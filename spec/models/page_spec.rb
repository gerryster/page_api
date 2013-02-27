require 'spec_helper'

describe Page do
  context "basic validations" do
    # Shoulda needs at least one existing record:
    before(:each) { Page.create! :title => "foo", :content => "bar" }

    it { should validate_uniqueness_of(:title) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  context "scope published", :slow => true do
    let!(:published) do
      Page.create! :title => "yesterday", :content => "published",
          :published_on => 1.day.ago
    end

    it "filters out pages with a null published_on" do
      unpublished = Page.create! :title => "unpublished", :content => "foo"
      Page.published.should == [published]
    end

    it "filters out pages with a published_on in the future" do
      unpublished = Page.create! :title => "unpublished", :content => "foo",
          :published_on => Time.now + 1.day
      Page.published.should == [published]
    end

    it "returns pages in order of published_on" do
      published2 = Page.create! :title => "an hour ago", :content => "published",
          :published_on => 1.hour.ago
      Page.published.should == [published2, published]
    end
  end

  context "scope unpublished", :slow => true do
    #let!(:unpublished) do
    #  Page.create! :title => "tomorrow", :content => "published",
    #      :published_on => 1.day.from_now
    #end

    it "returns pages with a null published_on" do
      unpublished = Page.create! :title => "unpublished", :content => "foo"
      Page.unpublished.should == [unpublished]
    end

    it "filters out pages with a published_on in the past" do
      Page.create! :title => "unpublished", :content => "foo",
          :published_on => 1.day.ago
      Page.unpublished.should == []
    end

    it "returns pages in order of published_on" do
      unpublished1 = Page.create! :title => "a day from now", :content => "unpublished",
          :published_on => 1.day.from_now
      unpublished2 = Page.create! :title => "an hour from now", :content => "unpublished",
          :published_on => 1.hour.from_now
      Page.unpublished.should == [unpublished1, unpublished2]
    end
  end
end
