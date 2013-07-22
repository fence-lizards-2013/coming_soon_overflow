class UsersController < ApplicationController 
  def show
    # TODO-JW: why set these at all rather than using current_user.(posts|votes) in the view?
    @posts = current_user.posts
    @votes = current_user.votes
  end
end
  
