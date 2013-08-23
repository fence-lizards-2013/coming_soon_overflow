class ApplicationController < ActionController::Base
  include RottenTomatoes
  # TODO-JW: externalize this! Use an ENV variable or something else.
  RT_API_KEY = "xh77z657kggvq5p974gv7zgy"

  protect_from_forgery
  before_filter :authenticate_user!, except: [:index, :new]
  # helper_method :my_helper_method # makes methods available to views
  
  # TODO-JW: This is only used in one place (posts_controller), so I wonder why
  # this is here rather than there?
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

end
