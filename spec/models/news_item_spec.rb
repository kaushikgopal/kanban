require 'spec_helper'

describe NewsItem do
  # let(:user){create(:user)}

  it "has a valid factory" do
    build(:news_item).should be_valid
  end
  it "should have a creator" do
    build(:news_item, user: nil).should_not be_valid
  end
  context "should have basic fields:" do
    it "check for content" do
      build(:news_item, content: nil).should_not be_valid
    end
  end


  # TODO use mocking and stubbing here
  it "should have an ordered method to retrieve news items in the descending order" do
    news_item_x = create(:news_item, created_at: DateTime.new(2012,01,01))
    news_item_y= create(:news_item, created_at: DateTime.new(2011,01,01))
    news_item_z= create(:news_item, created_at: DateTime.new(2012,03,01))

    # .all added to avoid comparison failure between groups of NewsItem objects an ActiveRel group.
    expect(NewsItem.ordered.all).to eql([news_item_z, news_item_x, news_item_y])
  end 




end
