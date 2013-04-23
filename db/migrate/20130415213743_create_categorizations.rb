class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :news_item_id
      t.integer :tag_id
      t.timestamps
    end
    add_index :categorizations, [:news_item_id, :tag_id], name: "categorization_index"
  end
end
