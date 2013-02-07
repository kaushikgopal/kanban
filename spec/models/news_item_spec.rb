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



end
