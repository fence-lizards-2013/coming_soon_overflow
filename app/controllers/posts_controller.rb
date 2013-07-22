class PostsController < ApplicationController
  
	def index
    # @posts = []
    # Post.find_each do |post|
    #   unless post.release_date.nil? ## this is just here because seeds don't have release_dates
    #     if Date.today < (post.release_date + 21)
    #       @posts << post
    #     end
    #   end
    # end
    @posts = Post.all
    @posts.sort_by do |post|
      post.votes.where(value: -1).count - post.votes.where(value: 1).count
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


	def sort_popularity
    @posts = Post.all.sort_by do |post|
      post.votes.where(value: -1).count - post.votes.where(value: 1).count
    end
    render :index
	end

  def sort_release_date

    @posts = Post.order("release_date DESC")
    render :index
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
