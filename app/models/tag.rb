class Tag < ActiveRecord::Base
  attr_accessible :tag_name, :slug

  has_many :categorizations
  has_many :news_items, through: :categorizations

  validates	:tag_name, :presence => { :message => "You need to have a tag name" }
  validates_uniqueness_of :slug

  before_save :create_tag_slug, if: :tag_name

  def to_param
  	slug
  end


  private
  def create_tag_slug
  	self.slug = self.tag_name.downcase.tr(" ", "_")
  	return true
  end

end
