class AddForeignkeyAssociationToNewsitem < ActiveRecord::Migration

	# forgetting to add this throws a deprecation warning. - see kanban learnings post.
  def up
  	add_column :news_items, :user_id, :integer
  end
  def down
  	remove_column :news_items, :user_id
  end

end
