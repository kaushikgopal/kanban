class NewsItem < ActiveRecord::Base
  attr_accessible :content

  has_many :tags
  belongs_to :user

  validates_presence_of :user, :message => "News item needs a creator"
  validates :content, :presence => { :message => "Your news item should have some content" }
  validate :max_tag_limit, if: :tags

  scope :ordered, order("created_at DESC")
  scope :news, joins(:tags).where("tags.tag_name = 'news'")

  private

  # TODO : Technically this doesn't do much. But we have a test case that checks this.
  #      : We never actually show it from here on the view. Might as well remove and add a different condition for testing from the controller.
  def max_tag_limit
  	errors.add(:tags, "You can only have maximum of 3 tags") if tags.count > 3
  end
end
