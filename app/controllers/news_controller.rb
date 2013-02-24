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
	end	

	def new
		@news_item = NewsItem.new
	end
	
	def create

		@news_item = NewsItem.new(params[:news_item])
		@user = get_tmp_user
		@user.news_items << @news_item
		
    
    respond_to do |format|
			if @news_item.save
        flash[:notice] = "News item was successfully created"
				# format.html  # creating through ajax so no view
				format.js
			end
		end
	end


	private

	def get_tmp_user
		User.create(username: "kaushikgopal", email: "tmp@kaush.co")
	end




end
