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
      fill_in 'tag_names', with: "Tag Name"
	   	click_button "Add News Item"
    }.to change(NewsItem,:count).by(1)
    visit stream_path
    page.should have_content "Test #{@random_string}"
  end

  describe "Basic Content" do
    before(:each) do
      @news_item = create(:news_item)
      visit stream_path
    end
    it "should show the tag" do
      @news_item = create(:news_item_with_random_tag)
      visit stream_path
      page.should have_content @news_item.tags[0].tag_name
    end
    it "should show the username" do
      page.should have_content @news_item.user.username
    end

    it "should show the stream content" do
      page.should have_content @news_item.content
    end
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

