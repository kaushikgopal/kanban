class NewsController < ApplicationController
	respond_to :js, :html

	def index
		@news_items = NewsItem.all
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
			tag_names.each do |tag_name|
				tag = Tag.new(tag_name: tag_name)
        existing_tag = Tag.where(slug: tag.slug)
				if existing_tag.count == 0
					tag.save
				else
					tag = existing_tag.first
				end
				tags << tag
			end
			@news_item.tags.concat tags
		end

#		@news_item.user = @user

		if !@news_item.save
      content = "Something went wrong - "
      @news_item.errors.full_messages.each { |msg| content += "#{msg} : " }
      flash[:error] = content
    else
      #flash[:notice] = "News item was successfully created"
    end
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
