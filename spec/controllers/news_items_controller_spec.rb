require 'spec_helper'

describe NewsItemsController do

  describe 'GET #index' do
    it "populates an array of news items" do
    	news_item = create(:news_item)
    	get :index
    	assigns(:news_items).should == [news_item]
    end
    it "renders the :index view" do
    	get :index
    	response.should render_template :index
    end
	end	

	describe 'GET #show' do
		let(:news_item){create(:news_item)}
		it "renders the :show view" do			
			get :show, id: news_item
			response.should render_template :show
		end
		it "assigns the requested news item to @news_item" do
			get :show, id: news_item
			assigns(:news_item).should == news_item
		end
	end

end
