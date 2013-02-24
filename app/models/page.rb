class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title

  validates_uniqueness_of :title
  validates_presence_of :title, :content
end
