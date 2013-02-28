class NewsController < ApplicationController
	respond_to :json, :html
	
	def index
		@news_items = NewsItem.all		
	end
	def show
		@news_item = NewsItem.find(params[:id])
	end
	def stream
		# @stream = NewsItem.find(:all, order: "created_at DESC")
		@stream = NewsItem.ordered
		# @stream = NewsItem.order("created_at DESC")
    respond_to do |format|
      format.js
      format.html
    end
	end	

	def new
		@news_item = NewsItem.new
	end
	
	def create
		@news_item = NewsItem.new(params[:news_item])
		@user = get_tmp_user
		@user.news_items << @news_item

    respond_to do |format|
			if !@news_item.save
        content = "Something went wrong - "
        @news_item.errors.full_messages.each { |msg| content += "#{msg} : " }
        flash[:error] = content
      else
        #flash[:notice] = "News item was successfully created"
      end
      format.js
		end
	end


	private

	def get_tmp_user
		user = User.find_by_username('kaushikgopal')
    user ||= User.create(username: 'kaushikgopal', email: 'tmp@kaush.co')
	end


end
