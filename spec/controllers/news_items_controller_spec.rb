require 'spec_helper'

describe NewsItemsController do

  describe 'GET #index' do
    it "populates an array of news items" do
    	news_item = create(:news_item)
    	get :index
    	assigns(:news_items).should eq [news_item]
    end
    it "renders the :index view" do
    	get :index
    	response.should render_template :index
    end
	end	



end
