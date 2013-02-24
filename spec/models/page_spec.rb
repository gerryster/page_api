require 'spec_helper'

describe Page do
  # Shoulda needs at least one existing record:
	before(:each) { Page.create! :title => "foo", :content => "bar" }

  it { should validate_uniqueness_of(:title) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
end
