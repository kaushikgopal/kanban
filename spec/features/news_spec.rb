require 'spec_helper'

describe	'News Management' do
	context 'List all News' do
		it "shows the list of news items" do
			visit news_path
			page.should have_content 'NewsItems'
		end
		it 'should have a new item created' do
			create(:news_item, content: "Testing page should have this content - 12349532")
			visit news_path
			page.should have_content 'Testing page should have this content - 12349532'
		end
	end

end