require 'spec_helper'

describe NewsController do
	context "News" do
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
		describe 'GET #show using basic mocking & stubbing' do
			it "assigns the requested news item to @news_item" do			
				# creating a mock news_item
				news_item = double(NewsItem)
				# stub ActiveRecord's find method on the NewsItem model itself
				NewsItem.stub(:find) { news_item }

				get :show, id: news_item 
				assigns(:news_item).should == news_item
			end
		end

		# basic show using advanced mocking & stubbing
		describe 'GET #show - advanced mocking & stubbing' do
			before(:each) do
				@mock_news_item = mock_news_item
				NewsItem.stub(:find) { mock_news_item }
				get :show, id: @mock_news_item
			end
			it "renders the :show view" do			
				response.should render_template :show
			end
			it "assigns the requested news item to @news_item" do
				assigns(:news_item).should == @mock_news_item
			end
		end

	end

	# TODO convert this test to not use Rails
	# stream functionality
	context "Streaming News" do
		describe "GET #stream" do
		  it "should assign news items to @stream in the descending order" do
		    
		    news_item_x = create(:news_item, created_at: DateTime.new(2012,01,01))
		    news_item_y= create(:news_item, created_at: DateTime.new(2011,01,01))
		    news_item_z= create(:news_item, created_at: DateTime.new(2012,03,01))
		    
		    # news_item1 = stub(NewsItem, :created_at => DateTime.now)
		    # news_item2 = stub(NewsItem, :created_at => DateTime.now)
		    # NewsItem.stub(:find) {}
		    
		    get :stream
		    # .all added to avoid comparison failure between groups of NewsItem objects an ActiveRel group.
		    expect(assigns(:stream).all).to eql([news_item_z, news_item_x, news_item_y])
		  end	
			it "renders the stream view" do
				get :stream
				response.should render_template :stream
			end
		end
		
		describe "GET #new" do
		  before(:each) do
		  	get :new
		  end
		  it "renders the :new view" do
		  	response.should render_template :new
		  end
		  it "creates a temporary news_item" do
		    assigns(:news_item).should be_a_new(NewsItem)
		  end
		end
	
		describe "POST #create" do
			it "should create a news_item" do
				expect{
					post :create, news_item: attributes_for(:news_item)	
				}.to change(NewsItem, :count).by(1)
		  end
		  it "should create a news_item - advanced mocking and stubbing" do
		  	# build the mocks
		  	# see http://stackoverflow.com/questions/3871966/testing-a-has-one-relationship for why a mock isn't suitable here
		  	news_item = NewsItem.new
		  	news_item.stub(:save).and_return(true)

				NewsItem.should_receive(:new).and_return(news_item)
				news_item.should_receive(:save)
				post :create, news_item: news_item
		  end
		end

		
		describe "DELETE #destroy" do
		  it "should delete a news_item" do
		  	news_item = mock_news_item
		  	news_item.stub!(:destroy).and_return(true)

		  	NewsItem.should_receive(:find).and_return(news_item)
		  	news_item.should_receive(:destroy).and_return(news_item)
		  	delete :destroy, id: news_item.id
		  end
		end

	end

	protected

	def mock_user
		 @mock_user ||= mock_model(User, {  :username => "User Name",
																	      :email => " iam@mock.com",
																	      :news_items => [mock_news_item]
																	    })
	end
	def mock_news_item
		 @mock_news_item ||= mock_model(NewsItem)
	end

end