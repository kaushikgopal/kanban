require 'spec_helper'

describe NewsItem do
  # let(:user){create(:user)}

  it "has a valid factory" do
    build(:news_item).should be_valid
  end

  it "should have a scope to retive only 'news' items" do
    expect(NewsItem.news.where_values).to eql(["tags.tag_name = 'news'"])
    expect(NewsItem.news.joins_values).to eql([:tags])
  end

  it "should not allow more than 140 characters in the content" do
    expect(build(:news_item, content: ("a"*141))).to_not be_valid
  end

  context "should have an ordered method" do
    # State based testing
    it " to retrieve news items in the descending order" do
      news_item_x = create(:news_item, created_at: DateTime.new(2012,01,01))
      news_item_y= create(:news_item, created_at: DateTime.new(2011,01,01))
      news_item_z= create(:news_item, created_at: DateTime.new(2012,03,01))
      # .all added to avoid comparison failure between groups of NewsItem objects an ActiveRel group.
      expect(NewsItem.ordered.all).to eql([news_item_z, news_item_x, news_item_y])
    end
    # Interaction based testing
    it "to retrieve news items in the descending order - using mocking and stubbing" do
      NewsItem.ordered.order_values.should == ['created_at DESC']
    end
  end

  context "should have basic fields:" do
    it "has content" do
      expect(build(:news_item, content: nil)).to_not be_valid
    end
    it "should have a creator" do
      expect(build(:news_item, user: nil)).to_not be_valid
    end

    describe "tags" do
      it "can have tags" do
        # news_item = create(:news_item)
        # news_item.tags.create(:tag_name => "sample_tag")
        # news_item.save
        news_item = create(:news_item_with_random_tag)
        news_item.tags.count.should == 1
      end
      it "cannot have more than 3 tags" do
        news_item = create(:news_item)
        tags = []
        4.times { tags << create(:tag) }
        news_item.tags << tags

        expect(news_item).to_not be_valid
        news_item.errors.messages[:base].should include "You can only have maximum of 3 tags"
      end
    end

  end

end