require 'spec_helper'

describe Tag do
	context "basic field checks" do
	  it "should have a tag name" do
	    build(:tag, tag_name: nil).should_not be_valid
	  end
	  it "should have a slug created automatically" do
	    tag = create(:tag, tag_name: "Tag XYZ")
	    expect(tag.slug).to eql("tag_xyz")
	  end	  
	end

  it "slugs should be unique" do
    tag1 = create(:tag)
    expect(create(:tag, tag_name: tag1.tag_name.downcase)).to_not be_valid
  end
end
