class RemoveOldAssociationFromNewsItemAndTag < ActiveRecord::Migration
  def up
  	remove_column :news_items, :tag_id
  	remove_column :tags, :news_item_id
  end

  def down
  	add_column :news_items, :tag_id, :integer
  	add_column :tags, :news_item_id, :integer
  end
end
