require 'spec_helper' # TODO convert this test to not use Rails

describe NewsController do
	context "News" do

	  describe 'GET #index' do
	    it "populates an array of news items tagged with 'news'" do
	    	news_item = FactoryGirl.create(:news_item)
	    	news_item_with_news_tag = FactoryGirl.create(:news_item_with_news_tag)
	    	get :index
	    	expect(assigns(:news_items)).to include(news_item_with_news_tag)
	    	expect(assigns(:news_items)).not_to include(news_item)
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

	# stream functionality
	context "Streaming News" do
		describe "GET #stream" do
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
			let(:user) { create(:user) }
			it "should create a news_item" do
				session[:user_id] = user.id
				expect{
					post :create, news_item: attributes_for(:news_item)
				}.to change(NewsItem, :count).by(1)
		  end
		  it "should create a news_item - advanced mocking and stubbing" do
				session[:user_id] = user.id
		  	# build the mocks
		  	# see http://stackoverflow.com/questions/3871966/testing-a-has-one-relationship for why a mock isn't suitable here
		  	#news_item = NewsItem.new
		  	#news_item.stub(:save).and_return(true)
        news_item = mock_model(NewsItem).as_null_object

        tag = mock_model(Tag, :slug => "tag_slug", :save => true)
        Tag.stub(:new).and_return(tag)

		  	Tag.should_receive(:new).exactly(3).times
				NewsItem.should_receive(:new).exactly(1).times.and_return(news_item)
				news_item.should_receive(:save).exactly(1).times
				post :create, news_item: news_item, tag_names: "Tag 1, Tag 2, Tag 3"
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
																	      :news_items => [mock_news_item] })
	end
	def mock_news_item
		 @mock_news_item ||= mock_model(NewsItem)
	end

end