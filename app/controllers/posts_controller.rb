class PostsController < ApplicationController
  
	def index
    posts = Post.where("release_date > ?", 3.weeks.ago)
    if params[:sort] == "release_date"
      @posts = Post.sort_by_release_date(posts)
    else
      @posts = Post.sort_by_popularity(posts)
    end
	end

	def new #get
    get_upcoming_movies
	end

	def create #post

    clips = HTTParty.get(params[:clips_url] + "?apikey=" + RT_API_KEY)
    unless clips['clips'].empty?
      trailer_url = clips['clips'].first['links']['alternate']
    else
      # TODO-JW: (UX feedback) Perhaps create a "no trailer found" view that
      # has a link that the user can click on that will take them to
      # trailers.apple.com to browse rather than sending them there without
      # warning.
      trailer_url = 'http://www.apple.com/trailers'
    end

    post = Post.new(title: params[:title], user_id: params[:user_id], image_url: params[:image_url],
     trailer_url: trailer_url, release_date: params[:release_date], critics_score: params[:critics_score], 
     critics_rating: params[:critics_rating], audience_score: params[:audience_score])
    if post.save
      redirect_to root_path
    else
      flash[:notice] = post.errors.full_messages.join(', ')
      redirect_to new_post_path
    end

	end

  def show
  end

  def movie_search
    @movies = Post.find_tomato params[:search]
    # @post = Post.new
    render :new
  end

  def destroy 
    post = Post.find params[:id]
    post.destroy
    redirect_to request.referer
  end

end
