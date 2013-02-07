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

	# basic show 
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

	# basic show using mocking & stubbing
	describe 'GET #show' do
		
		it "assigns the requested news item to @news_item" do			
			# creating a mock news_item
			news_item = double(NewsItem)
			# stub ActiveRecord's find method on the NewsItem model itself
			NewsItem.stub(:find) { news_item }

			get :show, id: news_item 
			assigns(:news_item).should == news_item
		end
	end

end
