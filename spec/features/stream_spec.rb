require 'spec_helper'

describe "Stream" do
  before(:all) do
    @random_string = "PhkOq6Fc57v8DlbcQFGxc0Or70i"
  end
  it "should be able to add a news_item" do
    visit stream_path
    click_link 'Add news item'
   	expect{
      fill_in 'news_item_content', with: "Test #{@random_string}"
	   	click_button "Add News Item"
    }.to change(NewsItem,:count).by(1)
    visit stream_path
    page.should have_content "Test #{@random_string}"
  end

  it "should be able to delete news_item" do
    # TODO control this with Cancan
    news_item = create(:news_item, content: "Test #{@random_string}")
    visit stream_path
    expect{
      within "#ni_#{news_item.id}" do
        click_link 'Delete'
      end
    }.to change(NewsItem, :count).by(-1)
    # sleep(1)
    should_not have_content "Test #{@random_string}"
  end

end