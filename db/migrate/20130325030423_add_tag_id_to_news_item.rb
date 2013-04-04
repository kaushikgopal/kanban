class AddTagIdToNewsItem < ActiveRecord::Migration
	def up
		add_column :news_items, :tag_id, :integer
		add_column :tags, :news_item_id, :integer
	end
	def down
		remove_column :news_items, :tag_id
		remove_column :tags, :news_item_id
	end

end
