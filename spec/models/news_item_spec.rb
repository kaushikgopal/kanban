require 'spec_helper'

describe NewsItem do
  it "has a valid factory" do
    build(:news_item).should be_valid
  end

  pending "has a creator"
  pending "has a time component"
  pending "has a \"sticky\" status"
end
