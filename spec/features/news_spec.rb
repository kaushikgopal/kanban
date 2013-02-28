require 'spec_helper'

describe	'News Management' do
	context 'List all News' do
		before(:all) do
	    @random_string = "PhkOq6Fc57v8DlbcQFGxc0Or70i"
	  end
		it "shows the list of news items" do
			visit news_path
			page.should have_content 'NewsItems'
		end
		it 'should have a new item created' do
			create(:news_item, content: "Testing page should have this content - #{@random_string }")
			visit news_path
			page.should have_content "Testing page should have this content - #{@random_string }"
		end
	end

end