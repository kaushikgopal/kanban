class NewsItem < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  has_many :tags, through: :categorizations
  has_many :categorizations

  validates_presence_of :user, :message => "News item needs a creator"
  validates :content,   :presence => { :message => "Your news item should have some content" },
                        :length => { :maximum => 140, :message => 'Message is too long. Please keep it within 140' }
                        # :length => {  :within => 0..140,
                        #               :too_short => 'Message is too short',
                        #               :too_long => 'Message is too long. Please keep it within 140' },

  validate :max_tag_limit, if: :tags

  scope :ordered, order("created_at DESC")
  scope :news, joins(:tags).where("tags.tag_name = 'news'")

  private

  def max_tag_limit
  	#errors.add(:tags, "You can only have maximum of 3 tags") if tags.length > 3
    errors[:base] << "You can only have maximum of 3 tags" if tags.length > 3
  end
end
