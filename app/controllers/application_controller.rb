class ApplicationController < ActionController::Base
  include RottenTomatoes

  protect_from_forgery
  before_filter :authenticate_user!, except: [:index, :new]
  # helper_method :my_helper_method # makes methods available to views
  
  def get_upcoming_movies
    @movies = params[:movies]

    upcoming_movies = HTTParty.get('http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey='+ RT_API_KEY )
    @prepopulated_upcoming_movies = upcoming_movies['movies']
    @prepopulated_upcoming_movies.each do |attr|
      bad_dates = attr['release_dates']['theater'].split('-').map{|d|d.to_i}
      ok_dates = Date.new(bad_dates[0],bad_dates[1],bad_dates[2])
      attr['release_dates']['theater'] = ok_dates.to_formatted_s(:long_ordinal)
    end
  end

  def get_request_path
    request_path = request.headers['HTTP_REFERER']
    request_path.slice! (request.headers['HTTP_ORIGIN'])
    request_path
  end


end
