require 'spec_helper'

describe User do
  it "has a valid factory" do
    build(:user).should be_valid
  end

  context "should have basic fields:" do
    it "check for user name" do
      build(:user, username: nil).should_not be_valid
    end
    it "check for either email address or twiki_name" do
      build(:user, email: nil, twiki_name: nil).should_not be_valid
    end
  end

end