require 'spec_helper'

describe "Stream" do
  it "should have an option to add a news_item" do
    visit stream_path
    click_link 'Add news item'
   	expect{
      fill_in 'news_item_content', with: "This is a test news item"
	   	click_button "Add News Item"
    }.to change(NewsItem,:count).by(1)
    visit stream_path
    page.should have_content "This is a test news item"
  end

  it "should have an option to delete news_item" do
    # TODO control this with Cancan
    news_item = create(:news_item, content: "Test ABC1234987")
    visit stream_path
    expect{
      within "#ni_#{news_item.id}" do
        click_link 'Delete'
      end
    }.to change(NewsItem, :count).by(-1)
    page.should_not have_content "Test ABC1234987"
  end

end