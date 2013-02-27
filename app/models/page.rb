class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title

  validates_uniqueness_of :title
  validates_presence_of :title, :content

  scope :published, where("published_on < ?", Time.now).order("published_on desc")
  scope :unpublished,
      where("published_on > ? OR published_on IS NULL", Time.now).order("published_on desc")

  def total_words
    word_count(title) + word_count(content)
  end

  def published?
    published_on && published_on < Time.now
  end

  private

  def word_count(string)
    string.nil? ? 0 : string.scan(/\S+/).count
  end
end
