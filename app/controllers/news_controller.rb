class NewsController < ApplicationController
	respond_to :js, :html

	def index
		@news_items = NewsItem.news
	end
	def show
		@news_item = NewsItem.find(params[:id])
	end
	def stream
		# @stream = NewsItem.find(:all, order: "created_at DESC")
		# @stream = NewsItem.order("created_at DESC")
		@stream = NewsItem.ordered
	end

	def new
		@news_item = NewsItem.new
	end

	def create

		@news_item = NewsItem.new(params[:news_item])

		unless current_user
			redirect_to root_url, notice: "You need to be signed in to create posts"
		end

		@user = current_user
    @news_item.user_id = @user.id

		if params[:tag_names]
			tag_ids = []
	    tag_names = params[:tag_names].split(', ')
    	tag_names.each do |tag_name|
				tag = Tag.find_or_create_by_tag_name(tag_name)
				tag_ids << tag.id
			end
			@news_item.tag_ids = tag_ids
		end

		if !@news_item.save
      error_content ||= "Something went wrong :"
      @news_item.errors.full_messages.each { |msg| error_content += "#{msg} : " }
      flash[:error] = error_content
    else
      # flash[:notice] = "News item was successfully created"
    end
    # render :nothing => true
	end

	def destroy
		@news_item = NewsItem.find(params[:id])
		@news_item.destroy
		respond_to do |format|
			format.js { render "delete" }
		end
	end

end
