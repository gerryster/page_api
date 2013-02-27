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

  describe "#total_words" do
    subject do
      Page.new(params)
    end

    context "a new object has 0" do
      let(:params) { {} }
      its(:total_words) { should == 0 }
    end

    context "a one word title" do
      let(:params) { {:title => "hello"} }
      its(:total_words) { should == 1 }
    end

    context "a one word title, three word content" do
      let(:params) { {:title => "hello", :content => "save big money"} }
      its(:total_words) { should == 4 }
    end
  end

  describe "#word_count" do
    specify "nil" do
      subject.send(:word_count, nil).should == 0 
    end
    specify "empty string" do
      subject.send(:word_count, "").should == 0 
    end
    specify "whitespace string" do
      subject.send(:word_count, " \n\t").should == 0 
    end
    specify "one word" do
      subject.send(:word_count, "one").should == 1 
    end
    specify "two words" do
      subject.send(:word_count, "one two").should == 2 
    end
    specify "two words separated by newlines and other witespace" do
      subject.send(:word_count, " one\ntwo\t").should == 2 
    end
  end
end
