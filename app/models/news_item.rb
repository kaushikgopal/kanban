class NewsItem < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  validates_presence_of :user, :message => "News item needs a creator" 
  
  validates :content, :presence => { :message => "Your news item should have some content" }
end
