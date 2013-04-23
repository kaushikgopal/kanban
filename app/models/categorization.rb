class Categorization < ActiveRecord::Base
  attr_accessible :news_item_id, :tag_id

  belongs_to :news_item
  belongs_to :tag
end
