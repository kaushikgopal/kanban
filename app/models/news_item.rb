class NewsItem < ActiveRecord::Base
  attr_accessible :content

  has_many :tags
  belongs_to :user
  
  validates_presence_of :user, :message => "News item needs a creator" 
  validates :content, :presence => { :message => "Your news item should have some content" }
  validate :max_tag_limit, if: :tags

  scope :ordered, order("created_at DESC")

  private

  def max_tag_limit
  	errors.add(:tags, "You can only have maximum of 3 tags") if tags.count > 3
  end
end
