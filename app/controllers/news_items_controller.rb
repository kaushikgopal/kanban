class NewsItemsController < ApplicationController
	respond_to :json, :html
	
	def index
		@news_items = NewsItem.all		
	end
	def show
		@news_item = NewsItem.find(params[:id])
	end
	

end
