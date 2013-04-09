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
		@user = get_tmp_user
    @news_item.user_id = @user.id

		if params[:tag_names]
			tags = []
	    tag_names = params[:tag_names].split(', ')
	    # if tag_names.count > 3
	    # 	flash[:error] = "You cannot have more than 3 tags."
	    # 	return
	    # else
				tag_names.each do |tag_name|
					tag = Tag.find_or_create_by_tag_name(tag_name)
					tags << tag
				end
				@news_item.tags.concat tags
			# end
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

	private

	def get_tmp_user
		user = User.find_by_username('kaushikgopal')
    user ||= User.create(username: 'kaushikgopal', email: 'tmp@kaush.co')
	end

end
