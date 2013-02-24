require 'spec_helper'

describe "Stream" do
  it "should have an option to add a news_item" do
    visit stream_path
    click_link 'Add news item'
   	
   	# expect{
      fill_in 'news_item_content', with: "This is a test news item"
	   	click_button "Add News Item"
    # }.to change(NewsItem,:count).by(1)
    # page.should have_content "This is a test news item"
  end

end